rm Loc.txt
for %%f in (data/*.properties) do (echo ¤ && echo [b]%%f[/b] && cat data/%%f) >> Loc.txt