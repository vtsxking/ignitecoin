#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

IGNITECOIND=${IGNITECOIND:-$BINDIR/ignitecoind}
IGNITECOINCLI=${IGNITECOINCLI:-$BINDIR/ignitecoin-cli}
IGNITECOINTX=${IGNITECOINTX:-$BINDIR/ignitecoin-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/ignitecoin-wallet}
IGNITECOINQT=${IGNITECOINQT:-$BINDIR/qt/ignitecoin-qt}

[ ! -x $IGNITECOIND ] && echo "$IGNITECOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BTCVER=($($IGNITECOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for ignitecoind if --version-string is not set,
# but has different outcomes for ignitecoin-qt and ignitecoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$IGNITECOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $IGNITECOIND $IGNITECOINCLI $IGNITECOINTX $WALLET_TOOL $IGNITECOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
