#!/usr/bin/python3
import subprocess
import threading
import sys
import os

def relay_stdout(proc):
    while True:
        output = proc.stdout.read(1)
        if output == b'' and proc.poll() is not None:
            break
        if output:
            sys.stdout.buffer.write(output)
            sys.stdout.buffer.flush()
    sys.stdout.close()

def relay_stdin(proc):
    while True:
        try:
            input = sys.stdin.read(1)
            if input:
                proc.stdin.write(input.encode())
                proc.stdin.flush()
            else:
                break
        except EOFError:
            break
    proc.stdin.close()

def main(command):
    proc = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=sys.stderr, stdin=subprocess.PIPE, text=False)
    thread_stdout = threading.Thread(target=relay_stdout, args=(proc,))
    thread_stdin = threading.Thread(target=relay_stdin, args=(proc,))
    thread_stdout.start()
    thread_stdin.start()
    thread_stdout.join()
    os._exit(0)

if __name__ == '__main__':
    if len(sys.argv) <= 1:
        sys.exit(1)
    command = sys.argv[1:]
    main(command)
