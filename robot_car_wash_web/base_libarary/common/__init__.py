import requests
import time

from robot.api import logger
from robot.errors import VariableError
from robot.running import EXECUTION_CONTEXTS

from base_libarary.utils.captcha import CaptchaOCR


class _CommonLibrary(object):
    def __init__(self):
        super(_CommonLibrary, self).__init__()

    @property
    def ctx(self):
        return EXECUTION_CONTEXTS.current

    @property
    def client(self):
        if hasattr(self.ctx, 'client'):
            return getattr(self.ctx, 'client')
        else:
            client = requests.session()
            setattr(self.ctx, 'client', client)
            return client

    @property
    def variables(self):
        return self.ctx.variables

    def get_variable(self, name, default=None):
        try:
            return self.variables[name]
        except VariableError:
            return default


class CommonLibrary(_CommonLibrary):
    def __init__(self):
        self.SERVER_DOMAIN = self.get_variable('${SERVER_DOMAIN}')
        super(CommonLibrary, self).__init__()

    def get_verify_code(self, vk, num=4):
        params = {
            'num': num,
            'vk': vk,
        }
        print(params)
        url = "{SERVER_DOMAIN}/admin/get_verify_code".format(
            SERVER_DOMAIN=self.SERVER_DOMAIN)
        resp = self.client.get(url, params=params)
        print(resp.url)
        print(resp.content)
        verify_code = CaptchaOCR(resp.content).verify_code
        while len(verify_code) != 4:
            verify_code = self.get_verify_code(vk, num)
        return verify_code

