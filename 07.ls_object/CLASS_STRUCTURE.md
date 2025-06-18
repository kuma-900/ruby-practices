### Entry

- **インスタンス変数**
  - `@file_name`
  - `@stat`
- **メソッド**
  - **public**
    - `initialize(file_name)`
    - `hidden?()`
    - `file_type_and_permission()`
    - `nlink()`
    - `owner_name()`
    - `group_name()`
    - `file_size()`
    - `mtime()`
    - `blocks()`
  - **private**
    - `octal_mode()`
    - `file_type()`
    - `permission()`

---

### EntryList

- **インスタンス変数**
  - `@entries`
- **メソッド**
  - **public**
    - `initialize(items)`
    - `each(&block)`
    - `sort_by_name()`
    - `remove_hidden()`
    - `reverse()`
    - `size()`
    - `[](index)`

---

### LsOptions

- **インスタンス変数**
  - `@options`
- **メソッド**
  - **public**
    - `initialize(argv)`
    - `show_hidden?()`
    - `reverse?()`
    - `long_format?()`

---

### LsFormatter

- **インスタンス変数**
  - `@entry_list`
  - `@options`
- **メソッド**
  - **public**
    - `initialize(entry_list, options)`
    - `format()`
  - **private**
    - `calculate_widths()`
    - `format_short()`
    - `format_long()`
