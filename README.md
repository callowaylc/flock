# flock

Example of opportunistic locking, using `flock`, to implement a semaphore-like access strategy.


## Requirements

- Bash
```sh
$ bash --version
GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin17)
Copyright (C) 2007 Free Software Foundation, Inc.
```

- Make
```sh
$ make -v
GNU Make 3.81
```

## Installation

Clone the repository.
```sh
git clone git@github.com:callowaylc-highlight/flock
```

## Usage

Run make to start process with epoch used as surrogate key.
```sh
$ echo $$
82052
$ make
./main.sh 1601299715
Sep 28 09:28:35  christian[81888] <Debug>: Waiting to aquire semaphore id=1601299715
Sep 28 09:28:35  christian[81890] <Debug>: Aquired semaphore id=1601299715 wait=0
Sep 28 09:28:35  christian[81891] <Debug>: Polling id=1601299715 time=0
Sep 28 09:28:40  christian[81893] <Debug>: Polling id=1601299715 time=5
```

In a second terminal, run make, which will launch the process but will block on waiting for semephore.
```sh
$ echo $$
82064
$ make
./main.sh 1601300128
Sep 28 09:35:28  christian[82097] <Debug>: Waiting to aquire semaphore id=1601300128
```

In the first terminal, sigkill `ctrl-c` the polling process.
```sh
^CSep 28 09:36:53  christian[82135] <Debug>: Released semaphore id=1601299715
make: *** [run] Error 130
```

Now flip back the second terminal, which should have aquired an exclusive lock.
```sh
make
./main.sh 1601300128
Sep 28 09:35:28  christian[82097] <Debug>: Waiting to aquire semaphore id=1601300128
...
Sep 28 09:36:53  christian[82136] <Debug>: Aquired semaphore id=1601300128 wait=85
Sep 28 09:36:53  christian[82138] <Debug>: Polling id=1601300128 time=85
```

## License

[MIT](https://choosealicense.com/licenses/mit/)

