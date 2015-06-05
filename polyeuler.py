#!/usr/bin/env python
"""
Usage:
polyeuler.py -h | --help
polyeuler.py [--lang=LANG] [--prob=PROB] [--tries=TRIES]

Options:
-h --help       Show this screen.
--lang=LANG     Only solve with a specific language.
--prob=PROB     Only solve a specific problem.
--tries=TRIES   Specify the number of tries. [default: 1]
"""
import os
import re
import subprocess
import sys

from python_util import docopt, ColumnPrinter


class Lang(object):
    def __init__(self, extension, to_built, runner=lambda x: ''):
        self.extension = extension
        self.to_built = to_built
        self.runner = runner


    @staticmethod
    def parse_time(t):
        m, s = re.match(r'^([\\.\d]+)m([\\.\d]+)s$', t).groups()
        return 60 * float(m) + float(s)


    def run(self, filename, times):
        command = '%(run)s; time for i in {1..%(n)s}; do %(run)s; done' % {
            'run': '%s %s' % (self.runner(filename), self.to_built(filename)),
            'n': times,
        }

        out, err = subprocess.Popen(
            command,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        ).communicate()

        try:
            time = sum(
                self.parse_time(x.split('\t')[-1])
                for x in err.split('\n')
                if x[:3] in ('use', 'sys')
            ) / times
        except Exception:
            raise Exception(err)

        return out.strip().split('\n')[-1], time


class Langs(object):
    def __init__(self):
        self.langs = dict()

        self.build()

    def __getitem__(self, lang):
        return self.langs[lang]

    def all(self):
        return sorted(self.langs.keys())


    def build(self):
        self.langs['c++'] = Lang('cpp', lambda x: x[:-3] + 'o')
        self.langs['clojure'] = Lang(
            'clj',
            lambda x: x,
            runner=lambda x: 'lein exec %s' % x
        )
        self.langs['python'] = Lang(
            'py',
            lambda x: x + 'c',
            runner=lambda x: 'python'
        )
        self.langs['scala'] = Lang(
            'scala',
            lambda x: re.sub(r'^.*(\d+).scala$', r'q\1', x),
            runner=lambda x: 'scala -classpath %s' % os.path.dirname(x)
        )


class PolyEuler(object):
    def __init__(self, language=None, problem=None, tries=1):
        self.langs = Langs()

        self.answers = {i: -1 for i in xrange(1, 1000)}
        self.answers[1] = 233168
        self.answers[2] = 4613732
        self.answers[3] = 6857
        self.answers[4] = 906609
        self.answers[5] = 232792560
        self.answers[6] = 25164150
        self.answers[7] = 104743
        self.answers[8] = 23514624000
        self.answers[10] = 142913828922
        self.answers[25] = 4782

        self.languages = [language] if language else self.langs.all()
        self.problems = [int(problem)] if problem else self.answers.keys()
        self.tries = tries


    @staticmethod
    def colorize(wrong):
        if not wrong:
            return 'Yes'
            # return '\033[92m%s\033[0m' % 'Yes'
        else:
            return wrong
            # return '\033[91m%s\033[0m' % wrong


    def time(self, filename, language, problem):
        out, time = self.langs[language].run(filename, self.tries)

        if out.strip() == str(self.answers[problem]):
            return False, time
        else:
            return ('Result: %s' % out.strip()), time

    def run(self):
        printer = ColumnPrinter(prefix='= ')
        printer.append(('Problem', 'Language', 'Correct?', 'Time (s)'))
        printer.append(('=======', '========', '========', '========'))

        for prob in self.problems:
            for lang in self.languages:
                filename = os.path.join(
                    os.path.dirname(os.path.realpath(__file__)),
                    str(prob).rjust(2, '0'),
                    '%s.%s' % (prob, self.langs[lang].extension)
                )
                if not os.path.isfile(filename):
                    continue

                wrong, time = self.time(filename, lang, prob)
                printer.append((
                    prob,
                    lang.title(),
                    self.colorize(wrong),
                    time
                ))

        printer.output()


if __name__ == '__main__':
    args = docopt(
        __doc__,
        argv=sys.argv[1:],
        transforms={
            '--tries': int
        }
    )

    poly = PolyEuler(
        args.get('--lang'),
        args.get('--prob'),
        args.get('--tries')
    )

    poly.run()
