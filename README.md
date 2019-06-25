# homebrew-mongodb

Simple setup scripts to get a MongoDB replica set up and running on OSX for development work.

This script leaves your original single process MongoDB instance running and controllable via `brew services` or manually if that is how you are doin it. You can start/stop/restart the replica set using the supplied `replicaset` command which you can copy to a location on your `PATH`.

## Requirements

- Homebrew installed. You can find it at [http://brew.sh/](http://brew.sh/)
- `brew install mongodb`

## Installation

Run the following commands in terminal:

```bash
git clone https://github.com/jlyonsmith/homebrew-mongodb.git
cd homebrew-mongodb
./install.sh
```

The MongoDB replica set will run on ports 27018 through 27020.

## Verification

You can verify your install by opening a mongo prompt with:

```bash
mongo --host 127.0.0.1:27018
```

It should say the following at the mongo prompt:

```bash
rs.PRIMARY>
```

Congratulations! You now have a working local replica set with mongodb.

## Removal

You can remove the replica set with:

```bash
./remove.sh
```

You'll need to restart the non-replica set MongoDB instance with `brew services restart mongodb`.
