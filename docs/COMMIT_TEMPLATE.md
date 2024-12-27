## Conventional Commits

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

The commit type can include the following:

-   `feat`  – a new feature is introduced with the changes
-   `fix`  – a bug fix has occurred
-   `chore`  – changes that do not relate to a fix or feature and don't modify src or test files (for example updating dependencies)
-   `refactor`  – refactored code that neither fixes a bug nor adds a feature
-   `docs`  – updates to documentation such as a the README or other markdown files
-   `style`  – changes that do not affect the meaning of the code, likely related to code formatting such as white-space, missing semi-colons, and so on.
-   `test`  – including new or correcting previous tests
-   `perf`  – performance improvements
-   `ci`  – continuous integration related
-   `build`  – changes that affect the build system or external dependencies
-   `revert`  – reverts a previous commit

The commit type subject line should be all lowercase with a character limit to encourage succinct descriptions.

The optional commit body should be used to provide further detail that cannot fit within the character limitations of the subject line description.

It is also a good location to utilize  `BREAKING CHANGE: <description>`  to note the reason for a breaking change within the commit.

The footer is also optional. We use the footer to link the JIRA story that would be closed with these changes for example:  `Closes D2IQ-<JIRA #>`  .

#### Full Conventional Commit Example

```
fix: fix foo to enable bar

This fixes the broken behavior of the component by doing xyz. 

BREAKING CHANGE
Before this fix foo wasn't enabled at all, behavior changes from <old> to <new>

Closes D2IQ-12345
```