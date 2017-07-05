

https://github.com/krallin/tini

NOTE: If you are using Docker 1.13 or greater, Tini is included in Docker itself. This includes all versions of Docker CE. To enable Tini, just pass the --init flag to docker run.

Why tini? (init backwards)

Using Tini has several benefits:

It protects you from software that accidentally creates zombie processes, which can (over time!) starve your entire system for PIDs (and make it unusable).
It ensures that the default signal handlers work for the software you run in your Docker image. For example, with Tini, SIGTERM properly terminates your process even if you didn't explicitly install a signal handler for it.
It does so completely transparently! Docker images that work without Tini will work with Tini without any changes.
If you'd like more detail on why this is useful, review this issue discussion: What is advantage of Tini?.

