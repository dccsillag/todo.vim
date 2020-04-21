`todo.vim`
===

There are many Vim plugins for working with TODO lists. However, there wasn't any which I was really happy with, so I made my own.

This plugin's features which make it different from the others include:

- You can have however many subtasks as you want (not limited to 2);
- The plugin doesn't try to act like Emacs by making you use a whole bunch of modifiers - all the bindings have a very Vim-esque feel to them;
- You can add (foldable) descriptions and comments to your tasks;
- Tasks can be marked either as _TODO_, _WIP_ or _done_;

More features coming soon!

Quickstart
---

Just set the filetype to `todo`:

```vim
:setf todo
```

The syntax for the TODOs are as follows: task entries start with `-`, `+` or `*` (just like Markdown lists); `-` means _TODO_, `+` means _done_ and `*` means _WIP_.

The plugin comes with some handy keybinds - if you use `o` or `O` when on a task entry line, the plugin will automatically add `- ` to the beginning of the new line (same follows for `<Return>` in insert mode);

Also, the plugin automatically runs `:setlocal fdm=syntax` for buffers of filetype `todo`. The syntax folding works just fine, but sometimes Vim fails to properly update the folds. If this happens, hitting `<C-L>` should solve the issue.

You can use `<Space>` to cycle through the task statuses (_TODO_, _WIP_ and _done_). If you use GVim, you can also use `<S-Space>` to cycle in the reverse order.
