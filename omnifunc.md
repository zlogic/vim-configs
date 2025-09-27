# Omnifunc improvements

[Vim 9 LSP](https://github.com/yegappan/lsp/) has a "compact" mode for excluding function signatures.

To achieve similar results, change the `vim.lsp.completion.enable` to have a custom function:

```lua
vim.api.nvim_create_autocmd('LspAttach', {
    ...
    -- Custom omnifunc formatting
    local convert_completion_item = function(item)
      local doc = item.documentation
      local info = item.detail or ''
      if doc then
        if type(doc) == 'string' then
	  info = info .. '\n- - -\n' .. doc
        elseif type(doc) == 'table' and type(doc.value) == 'string' then
	  info = info .. "\n- - -\n" .. doc.value
	else
	  vim.notify('invalid documentation value: ' .. vim.inspect(doc), vim.log.levels.WARN)
	end
      end
      return {
        menu = '', -- Do not show full signature
	info = info,
      }
    end

    ...
    -- Specify it as a convert function
    vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true, convert = convert_completion_item })
    ...

```

Note that Vim 9 LSP uses a custom filetype formatter (`lspgfm`) and can apply different formatting rules to text sections.
ALE uses a similar approach.

To achieve a similar result in Neovim, a custom handler would need to override the popup window properties.
It's better to wait for Neovim to add LSP markdown support in the mainline branch.
