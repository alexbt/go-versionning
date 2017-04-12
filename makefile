.VERSION:=1.0.0
.BRANCH:=`git branch | grep \* | cut -d ' ' -f2`
.GIT_HASH:=`git rev-parse --short HEAD`
.TIMESTAMP:=`date +%FT%T%z`
.LDFLAGS:=-ldflags "-X github.com/alexbt/go-versionning/pkg/public/version.TIMESTAMP=${.TIMESTAMP} -X github.com/alexbt/go-versionning/pkg/public/version.GIT_HASH=${.GIT_HASH} -X github.com/alexbt/go-versionning/pkg/public/version.GIT_BRANCH=${.BRANCH} -X github.com/alexbt/go-versionning/pkg/public/version.VERSION=${.VERSION}"
.BIN_NAME:=`basename "$(CURDIR)"`

all:
	${MAKE} getdeps
	${MAKE} clean
	govendor install ${.LDFLAGS} ./...
	${MAKE} test

install:
	${MAKE} all

build:
	${MAKE} getdeps
	${MAKE} clean
	govendor build ${.LDFLAGS} ./...
	${MAKE} test

vendor:
	go get -u github.com/kardianos/govendor
	govendor sync
	govendor update

getdeps:
	go get -u github.com/kardianos/govendor
	go get -d -t ./...

run:
	PORT=8081 ${.BIN_NAME}

test:
	govendor test -parallel 10 -cover ./...

clean:
	govendor clean

