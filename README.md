# Thoughts 💭

Thoughts is a POSIX-compliant shell program for making tweet-sized text posts and putting them on the internet. Thoughts has a terminal interface and runs on UNIX-based systems like MacOS, Linux, the BSDs, and WSL.

Thoughts keeps your thoughts in a single HTML file, and it syncs that file in a remote git repository. That HTML file is your thoughts page -- [It looks like this by default](https://dimriver.github.io/eoijctyoierugoci/), but it's highly customizable. It's up to you to serve the file from somewhere, but Thoughts handles everything else.

Thoughts can be installed on any number of computers, all updating the same remote HTML file.

Thoughts supports deployment on [GitHub Pages](https://pages.github.com/) out of the box. Simply [enable GitHub Pages](https://pages.github.com/) for your personal thoughts repo, and then post a new thought.

If you want a thoughts page but don't want to host it yourself, you can do that at https://thoughts.page. *Note: I don't run thoughts.page but I do endorse it* 👍🏻

Thoughts' only dependency is Git, and it should run without modification on any UNIX-based system. Please [open an issue](https://github.com/dimriver/thoughts/issues) if anything misbehaves.

## How it works

1. Install Thoughts
1. Type `thoughts` in a terminal and press ENTER
1. Your preferred text editor opens. Type your thought, then save and exit
1. Thoughts adds your thought to `thoughts.html` and `index.html`
1. Thoughts pushes your updated `thoughts.html` and `index.html` to a remote git repository

> :warning: `thoughts.html` and `index.html` are identical. They continue to both exist for backwards compatibility.

## Installing

Install thoughts with the `install.sh` script described below 👇🏻 

### First install:
(*Do this if you're making a new thoughts page*)

1. Install and [configure](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup) git
1. `git clone https://github.com/dimriver/thoughts.git ~/thoughts-source && cd ~/thoughts-source`
1. Install with `./install.sh`
1. Add `$HOME/.local/bin` to your PATH
1. Use `git init` to create a git repository in `$HOME/.local/share/thoughts`, then [point it at an empty remote origin](https://docs.github.com/en/free-pro-team@latest/github/importing-your-projects-to-github/adding-an-existing-project-to-github-using-the-command-line)
1. Be sure the repo is set up properly:
    ```
    $ cd ~/.local/share/thoughts
    $ git add .
    $ git commit -m "init"
    $ git push
    ```
1. From anywhere in your home directory, type `thoughts`

### Installing on another computer:

*(Do this if you already have a thoughts page)*

1. Clone `dimriver/thoughts` and `cd` into the cloned directory
1. Install with `./install.sh another`
1. Follow the prompts

## Commands

* `$ thoughts update`
  * Download and install the latest version of Thoughts
* `$ thoughts edit`
  * Edit your previously posted thoughts
* `$ thoughts style`
  * Customize the default CSS
* `$ thoughts preview`
  * Preview a thought in a browser while working on it

## "Markdown"

Thoughts supports non-standard markdown that's mostly just HTML.

* Italics
  * `You can write <em>italics</em>`
* Bold
  * `You can write in <strong>bold</strong>`
* Inline code
  * `You can write <code>inline code</code>`
* Code blocks
  * ```
    <block>
    You can write code blocks with this fake tag I invented.
    Each <block> tag must be on its own line or it won't parse correctly.
    Exactly like this.
    </block>
    ```
  * Thoughts uses [highlight.js](https://highlightjs.org/) for automatic syntax highlighting in code blocks. If you don't want this, simply remove it by modifying the default CSS.
* Links
  * Links are automatically linkified if they start with `http://` or `https://`, and the "h" has a space in front of it

Arbitrary HTML is theoretically supported outside of code blocks, but there are likely to be some inexplicable side-effects.

## Notes

* `thoughts.html` and `index.html` are identical. Initially, Thoughts only stored your thoughts in `thoughts.html`, but `index.html` was added later to support deployment to GitHub Pages. `thoughts.html` remains to avoid breaking existing installs.
* When typing a thought, newlines are converted to `<br>` in all cases.
  * Thoughts' goal is to make what you typed in vim appear on the internet, and to make it look roughly the way it did in vim. So, there will only be space between lines if you put it there -- space things how you want!
* Thoughts is wrapping lots of git behavior.
  * The `edit` and `style` commands don't only open HTML and CSS files for you; they also wrap git things so that your changes stay synced across all your computers.
  * If a git thing is breaking, manually inspect the situation in `$HOME/.local/share/thoughts`.
* If you post a thought that contains HTML outside of a `<block>` tag, that HTML will definitely render in the browser. It might work, or it might break. Experiment!
