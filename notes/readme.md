# Zettelkasten Workflow with zk

Knowledge management system using [zk](https://zk-org.github.io/zk/) CLI tool.

## Dependencies

- `zk` - CLI zettelkasten tool
- `neovim` - text editor
- `fzf` - fuzzy finder for interactive selection
- `bat` - file previewer
- `rg` - like grep, for searching in files

## Workflow

### Creating Notes

**Quick note creation:**
```bash
zk n                # new note with default template
zk todo             # new daily todo note
zk meeting          # new meeting note
```

**Note groups and templates:**
- **Default notes**: Date-based filename with metadata template
- **Daily todos**: Simple checklist format in `todo/` directory
- **Meetings**: Structured format with agenda and action items

### Finding & Editing Notes

```bash
zk ls               # interactive search of all notes
zk recent           # notes from last 7 days
zk recent-month     # notes from last 30 days
zk t                # filter by tag (interactive)
zk ta               # filter by tag, open all
zk edlast           # edit most recently modified note
zk open-tasks       # filter by tag, find all unresolved tasks (e.i. [ ])
```

### Organization

- **Hashtags**: Use `#tag` syntax for categorization
- **Frontmatter**: YAML metadata with date, title, tags
- **File naming**: Auto-generated with date and ID (`YYYY-MM-DD-xxxxxxxx.md`)

### Management

```bash
zk update # commit, pull and push all changes, if your notes folder has a git remote
zk clean # find empty notes and remove them
zk sync # do both tasks above
```

## TODO

- [ ] What if I want to publish a note? For example planning
- [ ] What if I want to read a note on the go? For example recipe
