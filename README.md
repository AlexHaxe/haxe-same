# hxSame game

remove all colored tiles to win the game!

## installation

```bash
gh repo clone AlexHaxe/hxSame
lix download
```

## running the game

`lime test html5`

`lime test hl`

`lime test linux`

`lime test windows` - untested

## unitests

`haxe test.hxml`

## UI-tests

### build game with UI-tests enabled

either

`lime test html5 -D uitests` - for HTML based test (keep browser window open for UI-tests)

`lime build hl -D uitests` - for hl based test

`lime build linux -D uitests` - for hxcpp based test (Linux)

`lime build windows -D uitests` - for hxcpp based test (Windows - untested)

### build UI-test runner

choose according to previous step

`haxe uitestHtml5.hxml`

`haxe uitestHl.hxml`

`haxe uitestLinux.hxml`

`haxe uitestWindows.hxml` - untested

### run UI tests

```bash
./bin/UITestMain
```
