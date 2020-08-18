build:
    # build Dockerfile from the current directory, also tag it as 'proxy'
	docker build -t proxy .


try:
	@echo "a" | echo null
	$(echo "a" | echo "b")