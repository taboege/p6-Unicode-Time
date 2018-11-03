.PHONY: all
all:
	@echo Use 'make README.md' to regenerate documentation, but be careful as Pod and/or Pod::To::Markdown do not support coercion types and enums, as well as certain C\<\> and E\<\> markups \(at the time of this writing\)

README.md: lib/Unicode/Time.pm6
	perl6 --doc=Markdown $< >$@
