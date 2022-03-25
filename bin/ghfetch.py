#!/usr/bin/python3
"""
ghfetch
requirements: github cli (gh)
"""

import argparse
import os

import github as gh


def write_file(f: gh.ContentFile) -> None:
    if not f.type == "file":
        raise Exception("not a file")

    print(f"file: {f.path}")
    try:
        os.makedirs(os.path.split(f.path)[0], 0o700)
    except FileExistsError:
        pass

    with open(f.path, "wb") as fh:
        fh.write(f.decoded_content)


def main():
    parser = argparse.ArgumentParser(description="x")
    parser.add_argument("--token", type=str, required=False, default=None)
    parser.add_argument("--owner", type=str, required=True)
    parser.add_argument("--repo", type=str, required=True)
    parser.add_argument("--branch", type=str, required=True)
    parser.add_argument("--file", type=str, required=True)
    parser.add_argument("--outdir", type=str, required=False, default=".")

    args = parser.parse_args()

    if args.token == "":
        args.token = None  # for public repos
    g = gh.Github(args.token)

    repo = g.get_repo(f"{args.owner}/{args.repo}")
    contents = repo.get_contents(args.file, ref=args.branch)

    os.chdir(args.outdir)

    if not isinstance(contents, list):
        # just one file
        write_file(contents)
        return

    # A list of files
    while contents:
        content = contents.pop(0)
        if content.type == "dir":
            contents.extend(repo.get_contents(content.path, ref=args.branch))
        else:
            write_file(content)


if __name__ == "__main__":
    main()
