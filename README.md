# Alpine Ruby container for legacy Rails applications

- Alpine 3.18
- OpenSSL 3.0
- Ruby 2.7.8

This container exists primarily for legacy Rails applications which are compatible with
OpenSSL 3.0 to run in an modern environment.

If you are one of those unlucky developers who need to maintain a legacy Rails application,
but need Ruby 2.7 with OpenSSL 3.0 support, as well as a modern environment, use this container as a starting point.

## Building

Run `./build-container.sh` to build the container. The resulting container will only
have a single layer. All temporary build files, build dependencies, and the toolchain
are removed from the final container to reduce its size from ~512MB to ~38MB (your results may vary).

## Download

Get a prebuilt container from [here](https://gitlab.com/magiruuvelvet/alpine-ruby-2.7-openssl3/container_registry):
`docker pull registry.gitlab.com/magiruuvelvet/alpine-ruby-2.7-openssl3`

## Q & A

 - **Q:** How to install Ruby bundler? \
   **A:** Install your desired version of bundler using: `gem install --no-user-install bundler -v $VERSION`. Bundler will never be available by default in this container.

 - **Q:** How do I get a newer version of RubyGems? \
   **A:** Try to perform a self-update of RubyGems and hope for the best. Note that Ruby 2.7 is EOL. Good luck!

 - **Q:** Can you provide other Linux distributions besides Alpine Linux? \
   **A:** No. I made this container for the applications I need to maintain which are all running on musl libc. If you need glibc, try to compile the container against another rootfs yourself.

## References

 - https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-lang/ruby/ruby-3.2.2-r4.ebuild
 - https://gitlab.archlinux.org/archlinux/packaging/packages/ruby2.7/-/blob/main/PKGBUILD
