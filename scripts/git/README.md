
### GitHub Actions

> actions/checkout@v2 fixed git@github.com problem

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v2
      with:
        fetch-depth: 0
        submodules: true
        token: ${{ secrets.PAT }}
```

```yaml
    - name: Fix submodules
      run: echo -e '[url "https://github.com/"]\n  insteadOf = "git@github.com:"' >> ~/.gitconfig
    - name: Checkout
      uses: actions/checkout@v1
      with:
        fetch-depth: 0
        submodules: true
        token: ${{ secrets.PAT }}
```
