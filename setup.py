from setuptools import setup, Extension

setup(
    name='one',
    version='0.1',
    description='C++ module for Python',
    ext_modules=[Extension('_one', sources=['one_wrap.cxx', 'one.cpp'], include_dirs=['.'])],
    py_modules=['one']
)