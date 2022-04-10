LIBRARY_NAME := pam_watchid.so
DESTINATION := /usr/local/lib/pam
ARCH := "$(shell uname -m)"
MACOS_VERSION := "$(shell sw_vers -productVersion)"
TRIPLE := "$(ARCH)-apple-macosx$(MACOS_VERSION)"

all:
	swiftc watchid-pam-extension.swift \
		-target "$(TRIPLE)" \
		-emit-library \
		-O \
		-o "$(LIBRARY_NAME)"

install: all
	mkdir -p "$(DESTINATION)"
	cp -f "$(LIBRARY_NAME)" "$(DESTINATION)/$(LIBRARY_NAME)"
	chmod 444 "$(DESTINATION)/$(LIBRARY_NAME)"
	chown root:wheel "$(DESTINATION)/$(LIBRARY_NAME)"
