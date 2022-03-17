<div align="center">
    <img src="https://github.com/godbout/kindaVim.theapp/blob/master/assets/icon.png">
    <h1>brings Vim moves to macOS input fields. and non input fields. is that everywhere yet?</h1>
</div>

![awesome stuff happening in there](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/gif.gif "hehe")

---

# THIS IS A PAID APP BUT IT'S ALSO OPEN SOURCE. HUH?

kindaVim is a paid app but you can check out the source, modify it, and compile it yourself if you like that. source is available here:

* App Core and kindaVim Engine Core: https://github.com/godbout/kindaVim
* Accessibility Engine, to handle the macOS Accessibility: https://github.com/godbout/AXEngine
* Accessibility Strategy, to handle Vim motions through text manipulation: https://github.com/godbout/AccessibilityStrategy
* Keyboard Strategy, to handle Vim motions through key mapping: https://github.com/godbout/KeyboardStrategy
* Commands, to handle Vim commands through key mapping: https://github.com/godbout/Commands
* KeyCombination, to wrap Apple keyboard events: https://github.com/godbout/KeyCombination
* Common, for shared structs, enums etc.: https://github.com/godbout/Common

# BUT I DONT WANNA COMPILE IT MYSELF #$@&%*!

great! get a license, it's one ☕️ (USD$3.69) a month: https://subscribe.kindavim.app

or use an old beta, they're free. last one is [1b25](https://github.com/godbout/kindaVim.theapp/releases/tag/1b.25).

# WHY KINDAVIM

brain space and energy are limited. why learning six hundred thousand new keyboard shortcuts when you can use Vim moves everywhere. also macOS is widely inconsistent like sometimes you can go up and down with ctrl+n/ctrl+p but also sometimes not. even in Apple's own apps. so jk FTW.

and also it's fucking cool.

# LOVED THE GIF?

maybe [watch the videos](https://www.youtube.com/channel/UC3ZP3QFMhNn3ivJgqoEW4Ug) first if you're not sure you wanna read further.

# WHAT APPS DOES THAT SHIT SUPPORT

## native apps with macOS Accessibility support

![Xcode input](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/Xcode-input.gif "Xcode input")

## native apps without macOS Accessibility support

![Mail input](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/Mail-input.gif "Mail input")

## restricted apps with some macOS Accessibility support

![Safari input](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/Safari-input.gif "Safari input")

## Electron apps with (kinda) proper macOS Accessibility support

![Logseq input](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/Logseq-input.gif "Logseq input")

## Electron apps with bad bad bad macOS Accessibility support

![ClickUp input](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/ClickUp-input.gif "ClickUp input")

## UI Elements

![Xcode UI1](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/Xcode-UI1.gif "Xcode UI1")
![Xcode UI2](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/Xcode-UI2.gif "Xcode UI2")
![Mail UI](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/Mail-UI.gif "Mail UI")
![Alfred UI](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/Alfred-UI.gif "Alfred UI")
![Help Menu UI](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/Help-Menu-UI.gif "Help Menu UI")

# HOW DOES THAT SHIT WORK

because the goal of kV is to bring Vim moves in **any** situation under macOS, it cannot use an already-existing Vim backend. hence, every single move is handcrafted to work in the following conditions:
* text is programmatically [readable and writable](#native-apps-with-macos-accessibility-support). in this condition kV does [text manipulation](#kV-accessibility-strategy). in theory we can have the full Vim experience. in practice there are MANY moves so some may currently be missing. feel free to [request](#feedback-%EF%B8%8F) the ones you need.
* text is programmatically [not readable](#native-apps-without-macOS-accessibility-support). in this condition kV achieves a Vim move through [key remapping](#kv-keyboard-strategy). it's not as precise as text manipulation.
* text is programmatically [readable but not writable](#restricted-apps-with-some-macOS-accessibility-support). in this condition kV uses a mix of text manipulation and key remapping. full Vim experience possible.
* text is part of an Electron app that returns [correct text data](#electron-apps-with-kinda-proper-macOS-accessibility-support), or [not](#electron-apps-with-bad-bad-bad-macOS-accessibility-support). in these conditions kV uses altered versions of the text manipulation and key remapping engines.
* [input is not text](#ui-elements). in this condition kV uses another type of key remapping, specific to UI Elements.

this whole mess allows for that awesome UX:

e.g. `/the`:

* input is text readable

![input text readable](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/search-AS.gif "input text readable")

* input is text not readable

![input text not readable](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/search-KSTE.gif "input text not readable")

* input is not text

![input not text](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/search-KSNTE.gif "input not text")

straight from your Vim brain to the underlying macOS. kV takes care of the mess in the middle.

# CURRENT VIM IMPLEMENTATION

## Motions

### kV Accessibility Strategy

| Normal Mode                            | count | &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Visual Mode | count |
| ---:                                   | :---:           | :---:                                | ---:                                        | :---:       
| `_`                                    | ✅️              |                                      | `_`                                         | ✅️️          
| `,`                                    | ✅️              |                                      | `,`                                         | ✅️          
| `;`                                    | ✅️              |                                      | `;`                                         | ✅️          
| `?`                                    | ✅️              |                                      | `^`                                         |             
| `?<CR>`                                | ✅️              |                                      | `+`, `<CR>`, `CTRL-M`                       | ✅️
| `[(`                                   | ❌️              |                                      | `<`                                         | ✅️
| `[(`                                   | ❌️              |                                      | `>`                                         | ✅️
| `[{`                                   | ❌️              |                                      | `$`, `<End>`                                | ✅️️          
| `])`                                   | ❌️              |                                      | `~`                                         |             
| `]}`                                   | ❌️              |                                      | `0`                                         |             
| `{`                                    | ❌️              |                                      | `B`, `<C-Left>`                             | ✅️          
| `}`                                    | ❌️              |                                      | `b`, `<S-Left>`                             | ✅️          
| `/`                                    | ✅️              |                                      | `C`                                         |             
| `/<CR>`                                | ✅️              |                                      | `c`, `s`                                    |             
| `%`                                    |                 |                                      | `D`                                         |             
| `^`                                    |                 |                                      | `d`, `<Del>`, `x`                           |             
| `+`, `<CR>`, `<CTRL-M>`                | ✅️️              |                                      | `E`                                         | ✅️          
| `<<`                                   | ✅️️              |                                      | `e`                                         | ✅️          
| `>>`                                   | ✅️️              |                                      | `F`                                         | ✅️          
| `~`                                    | ✅️              |                                      | `f`                                         | ✅️          
| `$`, `<End>`                           | ✅️              |                                      | `G`                                         | ✅️          
| `0`                                    |                 |                                      | `g_`                                        | ✅️
| `A`                                    | ❌️              |                                      | `g^`                                        |             
| `a`                                    | ❌️              |                                      | `g$`, `g<End>`                              | ✅️️          
| `B`, `<C-Left>`                        | ✅️️              |                                      | `g0`, `g<Home>`                             |             
| `b`, `<S-Left>`                        | ✅️️              |                                      | `gE`                                        | ✅️          
| `C`, `c$`                              | ❌️              |                                      | `ge`                                        | ✅️          
| `CTRL-R`                               | ✅️              |                                      | `gg`                                        | ✅️          
| `c0`                                   |                 |                                      | `gI`                                        |             
| `caW`                                  | ❌️              |                                      | `gj`, `g<Down>`                             | ✅️          
| `caw`                                  | ❌️              |                                      | `gk`, `g<Up>`                               | ✅️          
| `cB`                                   | ✅️️              |                                      | `h`, `<BS>`, `CTRL-H`, `<Left>`             | ✅️          
| `cb`                                   | ✅️️              |                                      | `iW`                                        | ❌️          
| `cc`                                   | ❌️              |                                      | `iw`                                        | ❌️          
| `cE`                                   | ✅️️              |                                      | `j`, `CTRL-J`, `CTRL-N`, `<Down>`           | ✅️          
| `ce`                                   | ✅️️              |                                      | `k`, `CTRL-P`, `<Up>`                       | ✅️          
| `cF`                                   | ✅️              |                                      | `l`, `<Right>`, `<Space>`                   | ✅️          
| `cf`                                   | ✅️              |                                      | `o`                                         |             
| `ch`                                   | ✅️              |                                      | `R`                                         |             
| `cG`                                   | ❌️              |                                      | `S`                                         |             
| `cgg`                                  | ❌️              |                                      | `T`                                         | ✅️          
| `ci'`                                  | ❌️              |                                      | `t`                                         | ✅️️          
| `ci"`                                  | ❌️              |                                      | `u`                                         | 
| `ci(`                                  | ❌️              |                                      | `V`                                         | ❌️          
| `ci)`                                  | ❌️              |                                      | `v`                                         | ❌️          
| `ci[`                                  | ❌️              |                                      | `W`, `<C-Right>`                            | ✅️          
| `ci]`                                  | ❌️              |                                      | `w`, `<S-Right>`                            | ✅️          
| `ci{`                                  | ❌️              |                                      | `X`                                         |             
| `ci}`                                  | ❌️              |                                      | `Y`                                         |             
| <code>ci`</code>                       | ❌️              |                                      | `y`                                         |                 
| `ciB`                                  | ❌️              |                                      
| `cib`                                  | ❌️              |                                      
| `ciW`                                  | ❌️              |                                      
| `ciw`                                  | ❌️              |                                      
| `cj`                                   | ❌️              |                                      
| `ck`                                   | ❌️              |                                      
| `cT`                                   | ✅️              |                                      
| `ct`                                   | ✅️              |                                      
| `cW`                                   | ❌️              |                                      
| `cw`                                   | ❌️              |                                      
| `D`, `d$`                              | ❌️              |                                      
| `d0`                                   |                 |                                      
| `daW`                                  | ❌️              |                                      
| `daw`                                  | ❌️              |                                      
| `dB`                                   | ✅️️              |                                      
| `db`                                   | ✅️️              |                                      
| `dd`                                   | ❌️              |
| `dE`                                   | ✅️️             
| `de`                                   | ✅️️             
| `dF`                                   | ✅️             
| `df`                                   | ✅️             
| `dG`                                   | ❌️             
| `dgg`                                  | ❌️            
| `diW`                                  | ❌️            
| `diw`                                  | ❌️            
| `dj`                                   | ❌️             
| `dk`                                   | ❌️             
| `dT`                                   | ✅️             
| `dt`                                   | ✅️             
| `dW`                                   | ✅️             
| `dw`                                   | ✅️             
| `E`                                    | ✅️️                 
| `e`                                    | ✅️️                 
| `F`                                    | ✅️                 
| `f`                                    | ✅️                 
| `G`                                    | ✅️                 
| `g_`                                   | ✅️     
| `g^`                                   | 
| `g$` , `g<End>`                        | ✅️                 
| `g0`, `g<Home>`                        |                  
| `gE`                                   | ✅️️                 
| `ge`                                   | ✅️️                 
| `gg`                                   | ✅️                 
| `gI`                                   | ❌️              
| `gj`, `g<Down>`                        | ✅️               
| `gk`, `g<Up>`                          | ✅️                 
| `H`                                    | ✅️
| `h`, `<BS>`, `CTRL-H`, `<Left>`        | ✅️                 
| `I`                                    | ❌️                 
| `i`                                    | ❌️               
| `J`                                    | ❌                 
| `j`, `CTRL-J`, `CTRL-N`, `<Down>`      | ✅️                 
| `k`, `CTRL-P`, `<Up>`                  | ✅️                 
| `L`                                    | ✅️
| `l`, `<Right>`, `<Space>`              | ✅️
| `M`                                    | ✅️
| `N`                                    | ✅️               
| `n`                                    | ✅️               
| `O`                                    | ❌️                 
| `o`                                    | ❌️                 
| `P`                                    | ❌️                 
| `p`                                    | ❌️                 
| `r`                                    | ✅️                 
| `S`                                    | ❌️                  
| `s`, `cl`                              | ✅️                  
| `T`                                    | ✅️                 
| `t`                                    | ✅️                 
| `u`                                    | ✅️                 
| `W`, `<C-Right>`                       | ✅️️                 
| `w`, `<S-Right>`                       | ✅️️                 
| `X`, `dh`                              | ✅️                 
| `x`, `<Del>`, `dl`                     | ✅️                  
| `Y`                                    | ✅️                  
| `yF`                                   | ✅️                 
| `yf`                                   | ✅️                 
| `yi'`                                  | ❌️                 
| `yi"`                                  | ❌️                 
| `yi(`                                  | ❌️                 
| `yi)`                                  | ❌️                 
| `yi[`                                  | ❌️                 
| `yi]`                                  | ❌️                 
| `yi{`                                  | ❌️                 
| `yi}`                                  | ❌️                 
|  <code>yi`</code>                      | ❌️ 
| `yiw`                                  | ❌️ 
| `yT`                                   | ✅️ 
| `yt`                                   | ✅️ 
| `yy`                                   | ✅️ 

### kV Keyboard Strategy

| Normal Mode                                 | count | &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Visual Mode  | count | 
| ---:                                        | :---: | :---:                                | ---:                                       | :---:
| `_`                                         | ❌️    |                                      | `_`                                        | ❌️              
| `?`                                         | ❌️    |                                      | `^`                                        |                 
| `?<CR>`                                     | ❌️    |                                      | `+`, `<CR>`, `CTRL-M`                      | ✅️              
| `/`                                         | ❌️    |                                      | `$`, `<End>`                               | ❌️              
| `/<CR>`                                     | ❌️    |                                      | `0`                                        |                 
| `^`                                         |       |                                      | `b`, `<S-Left>`                            | ✅️️              
| `+`, `<CR>`, `CTRL-M`                       | ✅️️    |                                      | `C`                                        |                 
| `<<`                                        | ✅️️    |                                      | `c`, `s`                                   |                 
| `>>`                                        | ✅️️    |                                      | `D`                                        |                 
| `$`, `<End>`                                | ❌️    |                                      | `d`, `<Del>`, `x`                          |                 
| `0`                                         |       |                                      | `e`                                        | ✅️️              
| `A`                                         | ❌️    |                                      | `G`                                        | ❌️              
| `a`                                         | ❌️    |                                      | `g^`                                       |                 
| `b`, `<S-Left>`                             | ✅️️    |                                      | `g_`                                       | ❌️
| `C`, `c$`                                   | ❌️    |                                      | `g$`, `g<End>`                             | ❌️              
| `CTRL-B`                                    | ❌️    |                                      | `g0`, `g<Home>`                            |                 
| `CTRL-D`                                    | ❌️    |                                      | `ge`                                       | ✅️️              
| `CTRL-F`                                    | ❌️    |                                      | `gg`                                       | ❌️              
| `CTRL-R`                                    | ✅️️    |                                      | `gI`                                       |                 
| `CTRL-U`                                    | ❌️    |                                      | `gj`, `g<Down>`                            | ✅️              
| `c0`                                        |       |                                      | `gk`, `g<Up>`                              | ✅️              
| `cb`                                        | ✅️️    |                                      | `h`, `<BS>`, `CTRL-H`, `<Left>`            | ✅️              
| `cc`                                        | ❌️    |                                      | `iw`                                       | ❌️              
| `ce`                                        | ✅️️    |                                      | `j`, `CTRL-J`, `CTRL-N`, `<Down>`          | ✅️              
| `cG`                                        | ❌️    |                                      | `k`, `CTRL-P`, `<Up>`                      | ✅️              
| `cgg`                                       | ❌️    |                                      | `l`, `<Right>`, `<Space>`                  | ✅️              
| `ch`                                        | ✅️️    |                                      | `R`                                        | ❌️              
| `ciw`                                       | ❌️    |                                      | `S`                                        | ❌️              
| `cj`                                        | ❌️    |                                      | `u`                                        |         
| `ck`                                        | ❌️    |                                      | `V`                                        | ❌️              
| `cw`                                        | ✅️️    |                                      | `v`                                        | ❌️              
| `D`, `d$`                                   | ❌️    |                                      | `w`, `<S-Right>`                           | ✅️️              
| `d0`                                        |       |                                      | `X`                                        |                 
| `db`                                        | ✅️️    |                                      | `Y`                                        |                                        
| `dd`                                        | ❌️    |                                      | `y`                                        |                  
| `de`                                        | ✅️️    |                                      
| `dG`                                        | ❌️    |                                      
| `dgg`                                       | ❌️    |                                      
| `diw`                                       | ❌️    |                                      
| `dj`                                        | ❌️    |                                      
| `dk`                                        | ❌️    |                                      
| `dw`                                        | ❌️    |                                     
| `e`                                         | ✅️️    |                                      
| `G`                                         | ❌️    |                                      
| `g_`                                        | ❌️    |                                        
| `g^`                                        |       |                                      
| `g$`, `g<End>`                              | ❌️    |                                      
| `g0`, `g<Home>`                             |       |                                      
| `ge`                                        | ✅️️    |
| `gg`                                        | ❌️    |
| `gI`                                        | ❌️    |
| `gj`, `g<Down>`                             | ✅️    |
| `gk`, `g<Up>`                               | ✅️    |
| `h`, `<BS>`, `CTRL-H`, `<Left>`             | ✅️    |
| `i`                                         | ❌️    |
| `J`                                         | ❌️    |
| `j`, `CTRL-J`, `CTRL-N`, `<Down>`           | ✅    |
| `k`, `CTRL-P`, `<Up>`                       | ✅    |
| `l`, `<Right>`, `<Space>`                   | ✅    |
| `N`                                         | ✅️    |
| `n`                                         | ✅️    |
| `O`                                         | ❌️    |
| `o`                                         | ❌️    |
| `P`                                         | ❌️    |
| `p`                                         | ❌️    |
| `r`                                         | ❌️    |
| `S`                                         | ❌️    | ️
| `s`, `cl`                                   | ✅️️    |
| `u`                                         | ✅️️    |
| `w`, `<S-Right>`                            | ✅️️    |
| `X`, `dh`                                   | ✅️️    |
| `x`, `<Del>`, `dl`                          | ✅️️    |
| `Y`                                         | ❌️    |
| `yiw`                                       | ❌️    |
| `yy`                                        | ❌️    |

### Commands
| Command | count |
| :---:   | :---: |
| `:q`    |
| `:q!`   |
| `:w`    |            
| `:wq`   |            
| `:x`    |
| `gT`    | ✅️️
| `gt`    | ❌️
| `ZZ`    |

# DID YOU KNOW?

![bye bye caps lock](https://raw.githubusercontent.com/godbout/kindaVim.theapp/master/assets/did-you-know.png "haha")

# ROADMAP

* add a plethora of missing Vim moves ([ask!](https://github.com/godbout/kindaVim.theapp/issues/new))
* update all moves to support new global count system ([ask!](https://github.com/godbout/kindaVim.theapp/issues/new))
* some kind of config file system (.kVrc? read .vimrc? UI key remapping?)
* users' requests

# FEEDBACK

* whether you need a missing move, want to report a bug or ask for a feature, just [open an issue](https://github.com/godbout/kindaVim.theapp/issues/new).

# ACKNOWLEDGMENTS, THANKS, AND KISSES

* [Takayama Fumihiko](https://github.com/tekezo) for [Karabiner-Elements](https://karabiner-elements.pqrs.org), my first experience of Vim moves on macOS. great option if you need lots of customizations
* [David Balatero](https://github.com/dbalatero) for [VimMode.spoon](https://github.com/dbalatero/VimMode.spoon), showing there's a way to make that shit work. great option if you're looking for free/open source
* [Sindre Sorhus](https://github.com/sindresorhus) for [LaunchAtLogin](https://github.com/sindresorhus/LaunchAtLogin) and [KeyboardShortcuts](https://github.com/sindresorhus/KeyboardShortcuts), that saved me countless of hours of headaches
* [Sparkle](https://sparkle-project.org) for the Sofware Updater. this is good shit
* [Clipy](https://github.com/Clipy) for [Sauce](https://github.com/Clipy/Sauce), a magnificent Swift package to handle Keyboard Layouts headaches shits
