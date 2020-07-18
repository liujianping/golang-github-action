PROJECT=golang-github-action
DOCKER_USER=liujianping

# These are the values we want to pass for Version and BuildTime
GITTAG=`git describe --tags`
COMMIT=`git rev-parse HEAD`
BUILD_TIME=`date +%FT%T%z`

# Setup the -ldflags option for go build here, interpolate the variable values
FLAGS="-X github.com/x-mod/build.version=${GITTAG} -X github.com/x-mod/build.commit=${COMMIT}"

build:
	go build -o ${PROJECT} -ldflags ${FLAGS}

image:
	docker build --build-arg TOKEN=${TOKEN} --build-arg VERSION=${GITTAG} --build-arg COMMIT=${COMMIT} --build-arg BUILDTIME=${BUILD_TIME} -t ${DOCKER_USER}/${PROJECT}:latest .