#!/bin/sh
buildAll () {

	echo '================================================================================'
	echo $'			build base: START'
	echo '================================================================================'
	./scripts/base/build.sh
	echo '================================================================================'
	echo $'			build base: END'

	echo '================================================================================'
	echo $'			build uuid service'
	echo '================================================================================'
	./scripts/uuid/build.sh

	echo '================================================================================'
	echo $'			build employee service'
	echo '================================================================================'
	./scripts/employee/build.sh

	echo '================================================================================'
	echo $'			build project service'
	echo '================================================================================'
	./scripts/project/build.sh

	echo '================================================================================'
	echo $'			build project assignment service'
	echo '================================================================================'
	./scripts/project-assignment/build.sh

	echo '================================================================================'
	echo $'			build device registration service'
	echo '================================================================================'
	./scripts/device-registration/build.sh

	echo '================================================================================'
	echo $'			build device authentication service'
	echo '================================================================================'
	./scripts/device-authentication/build.sh

	echo '================================================================================'
	echo $'			build organisation web'
	echo '================================================================================'
	./scripts/organisation-web/build.sh
}

buildAll