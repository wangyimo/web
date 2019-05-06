from io import BytesIO

import itertools

import os
import time

import requests
from PIL import Image


class CaptchaOCRException(Exception):
    pass


class CaptchaOCR(object):
    """
    验证码识别

    在使用之前需要安装[Google’s Tesseract-OCR Engine](https://github.com/tesseract-ocr/tesseract)，
    然后将`captcha.traineddata`文件放到tessdata安装目录的tessdata目录下。
    """

    def __init__(self, image):
        if isinstance(image, Image.Image):
            image = image
        elif isinstance(image, bytes):
            image = Image.open(BytesIO(image))
        elif isinstance(image, str):
            image = Image.open(image)
        else:
            raise CaptchaOCRException()

        self.ocr_url = 'https://ocr-d.parkone.cn/ocr/captcha'
        self.origin_image = image
        self.image = image.copy()
        self._verify_code = ''

    @classmethod
    def get_num(cls):
        _num = getattr(cls, '_num', 0)
        cls._num = _num + 1
        return cls._num

    @property
    def width(self):
        return self.image.width

    @property
    def height(self):
        return self.image.height

    @property
    def verify_code(self):
        if self._verify_code == '':
            self._verify_code = self.detect()
        return self._verify_code

    @property
    def pixels(self):
        return self.image.load()

    def image_to_string(self):
        verify_code = ''
        for im in self._cut():
            buf = BytesIO()
            im.save(buf, 'png')
            buf.seek(0)
            resp = requests.post(
                url=self.ocr_url,
                data={'lang': 'captcha', 'psm': '10'},
                files=[
                    ('captcha', ('captcha.png', buf.getvalue(), 'image/png'))]
            )
            verify_code += resp.json().get('text', '')
        # for im in self._cut():
        #     im = im.convert('L')
        #     # im.show()
        #     code = pytesseract.image_to_string(
        #         im, lang='captcha', config='--psm 10')
        #     verify_code += code
        return verify_code
        # self.image = self.image.convert('L')
        # self.image.show()
        # verify_code = pytesseract.image_to_string(self.image, lang='captcha')
        # return verify_code

    def detect(self):
        self._remove_background()
        # image.show()
        self._remove_noise()
        # image.show()
        self._remove_line()
        self._remove_noise()
        return self.image_to_string()

    def _remove_background(self):
        pixels, width, height = self.pixels, self.width, self.height
        obj, back_pix = {}, None
        for i, j in itertools.product(range(width), range(height)):
            if obj.get(pixels[i, j], 0) >= 100:
                back_pix = pixels[i, j]
                break
            else:
                obj[pixels[i, j]] = obj.get(pixels[i, j], 0) + 1
        if back_pix is not None:
            for i, j in itertools.product(range(width), range(height)):
                if pixels[i, j] == back_pix:
                    pixels[i, j] = (255, 255, 255)

    def _remove_noise(self):
        pixels, width, height = self.pixels, self.width, self.height
        for i, j in itertools.product(range(width), range(height)):
            if pixels[i, j] != (0, 0, 0):
                continue
            colorful, black = 0, 0
            for _i, _j in itertools.product(
                    range(i - 1, i + 2), range(j - 1, j + 2)):
                if min([_i,
                        _j]) < 0 or _i >= width or _j >= height:
                    continue
                if pixels[_i, _j] == (0, 0, 0):
                    black += 1
                elif pixels[_i, _j] != (255, 255, 255):
                    colorful += 1
            if colorful <= 2 or black < 2:
                pixels[i, j] = (255, 255, 255)
                continue

    def _remove_line(self):
        pixels, width, height = self.pixels, self.width, self.height
        p = None
        for i, j in itertools.product(range(width), range(height)):
            if pixels[i, j] == (255, 255, 255):
                continue

            status, points = self._check(i, j)
            if status:
                for _ in points:
                    _s, _ps = self._check(*_)
                    status &= _s
            if status:
                p = pixels[i, j]
                break

        if p is not None:
            for i, j in itertools.product(range(width), range(height)):
                if pixels[i, j] == p:
                    pixels[i, j] = (255, 255, 255)

    def _check(self, x, y):
        pixels, width, height = self.pixels, self.width, self.height
        points = ((x + 1, y), (x + 1, y + 1), (x, y + 1), (x - 1, y + 1))
        points = [_ for _ in points if
                  0 <= _[0] < width and 0 <= _[1] < height]

        p, n, arr = pixels[x, y], 0, []
        for _ in points:
            if pixels[_] != p and pixels[_] != (255, 255, 255):
                return False, []
            elif pixels[_] == p:
                n += 1
                arr.append(_)

        return n > 0, arr

    def _cut(self):
        pixels, width, height = self.pixels, self.width, self.height
        whites = []
        for i in range(width):
            m = -1
            for j in range(height):
                if pixels[i, j] != (255, 255, 255):
                    m = i
                    break
            if m < 0:
                whites.append(i)

        regions = []
        for i in range(1, len(whites)):
            if whites[i] != whites[i - 1] + 1:
                regions.append((whites[i - 1], whites[i]))

        crops = []
        for region in regions:
            box = (region[0], 0, region[1] + 1, height)
            crop = self.image.crop(box)
            # crop.save(BytesIO(), 'PNG')
            crops.append(crop)

        return crops if len(crops) > 3 else []

    def save(self, file_path):
        image = self.image.convert('L')
        if os.path.isdir(file_path):
            file_path = '%s/%s.png' % (file_path, time.time())
        image.save(file_path, 'png')


if __name__ == '__main__':

    def func():
        verify_key = int(time.time() * 10000)
        url = "https://car-wash-server-d.parkone.cn/admin/get_verify_code"
        resp = requests.get(url, params={'vk': 'qhj0xvs0sp', 'num': '4'})
        verify_code = CaptchaOCR(resp.content).verify_code

        print(verify_code)
        if len(verify_code) != 4:
            return False
        url = "https://car-wash-server-d.parkone.cn/admin/login"
        resp = requests.post(url, data={
            'username': 'admin',
            'password': 'admin123',
            'verify_key': verify_key,
            'verify_code': verify_code,
        })
        return resp.status_code == 204


    def main():
        m, n = 10, 0
        for _ in range(m):
            n += 1 if func() else 0
        print('>>>> %s, %s, %.4f' % (m, n, n / m))


    main()
