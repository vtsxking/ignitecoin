# Copyright (c) 2013-2016 The Ignitecoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

DIST_SUBDIRS = secp256k1 univalue

AM_LDFLAGS = $(PTHREAD_CFLAGS) $(LIBTOOL_LDFLAGS) $(HARDENED_LDFLAGS) $(GPROF_LDFLAGS) $(SANITIZER_LDFLAGS)
AM_CXXFLAGS = $(DEBUG_CXXFLAGS) $(HARDENED_CXXFLAGS) $(WARN_CXXFLAGS) $(NOWARN_CXXFLAGS) $(ERROR_CXXFLAGS) $(GPROF_CXXFLAGS) $(SANITIZER_CXXFLAGS)
AM_CPPFLAGS = $(DEBUG_CPPFLAGS) $(HARDENED_CPPFLAGS)
AM_LIBTOOLFLAGS = --preserve-dup-deps
EXTRA_LIBRARIES =

if EMBEDDED_UNIVALUE
LIBUNIVALUE = univalue/libunivalue.la

$(LIBUNIVALUE): $(wildcard univalue/lib/*) $(wildcard univalue/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)
else
LIBUNIVALUE = $(UNIVALUE_LIBS)
endif

IGNITECOIN_INCLUDES=-I$(builddir) $(BDB_CPPFLAGS) $(BOOST_CPPFLAGS) $(LEVELDB_CPPFLAGS) $(CRYPTO_CFLAGS) $(SSL_CFLAGS)

IGNITECOIN_INCLUDES += -I$(srcdir)/secp256k1/include
IGNITECOIN_INCLUDES += $(UNIVALUE_CFLAGS)

LIBIGNITECOIN_SERVER=libignitecoin_server.a
LIBIGNITECOIN_COMMON=libignitecoin_common.a
LIBIGNITECOIN_CONSENSUS=libignitecoin_consensus.a
LIBIGNITECOIN_CLI=libignitecoin_cli.a
LIBIGNITECOIN_UTIL=libignitecoin_util.a
LIBIGNITECOIN_CRYPTO_BASE=crypto/libignitecoin_crypto_base.a
LIBIGNITECOINQT=qt/libignitecoinqt.a
LIBSECP256K1=secp256k1/libsecp256k1.la

if ENABLE_ZMQ
LIBIGNITECOIN_ZMQ=libignitecoin_zmq.a
endif
if BUILD_IGNITECOIN_LIBS
LIBIGNITECOINCONSENSUS=libignitecoinconsensus.la
endif
if ENABLE_WALLET
LIBIGNITECOIN_WALLET=libignitecoin_wallet.a
LIBIGNITECOIN_WALLET_TOOL=libignitecoin_wallet_tool.a
endif

LIBIGNITECOIN_CRYPTO= $(LIBIGNITECOIN_CRYPTO_BASE)
if ENABLE_SSE41
LIBIGNITECOIN_CRYPTO_SSE41 = crypto/libignitecoin_crypto_sse41.a
LIBIGNITECOIN_CRYPTO += $(LIBIGNITECOIN_CRYPTO_SSE41)
endif
if ENABLE_AVX2
LIBIGNITECOIN_CRYPTO_AVX2 = crypto/libignitecoin_crypto_avx2.a
LIBIGNITECOIN_CRYPTO += $(LIBIGNITECOIN_CRYPTO_AVX2)
endif
if ENABLE_SHANI
LIBIGNITECOIN_CRYPTO_SHANI = crypto/libignitecoin_crypto_shani.a
LIBIGNITECOIN_CRYPTO += $(LIBIGNITECOIN_CRYPTO_SHANI)
endif

$(LIBSECP256K1): $(wildcard secp256k1/src/*.h) $(wildcard secp256k1/src/*.c) $(wildcard secp256k1/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)

# Make is not made aware of per-object dependencies to avoid limiting building parallelization
# But to build the less dependent modules first, we manually select their order here:
EXTRA_LIBRARIES += \
  $(LIBIGNITECOIN_CRYPTO) \
  $(LIBIGNITECOIN_UTIL) \
  $(LIBIGNITECOIN_COMMON) \
  $(LIBIGNITECOIN_CONSENSUS) \
  $(LIBIGNITECOIN_SERVER) \
  $(LIBIGNITECOIN_CLI) \
  $(LIBIGNITECOIN_WALLET) \
  $(LIBIGNITECOIN_WALLET_TOOL) \
  $(LIBIGNITECOIN_ZMQ)

lib_LTLIBRARIES = $(LIBIGNITECOINCONSENSUS)

bin_PROGRAMS =
noinst_PROGRAMS =
TESTS =
BENCHMARKS =

if BUILD_IGNITECOIND
  bin_PROGRAMS += ignitecoind
endif

if BUILD_IGNITECOIN_CLI
  bin_PROGRAMS += ignitecoin-cli
endif
if BUILD_IGNITECOIN_TX
  bin_PROGRAMS += ignitecoin-tx
endif
if ENABLE_WALLET
if BUILD_IGNITECOIN_WALLET
  bin_PROGRAMS += ignitecoin-wallet
endif
endif

.PHONY: FORCE check-symbols check-security
# ignitecoin core #
IGNITECOIN_CORE_H = \
  addrdb.h \
  addrman.h \
  attributes.h \
  banman.h \
  base58.h \
  bech32.h \
  bloom.h \
  blockencodings.h \
  blockfilter.h \
  chain.h \
  chainparams.h \
  chainparamsbase.h \
  chainparamsseeds.h \
  checkpoints.h \
  checkqueue.h \
  clientversion.h \
  coins.h \
  compat.h \
  compat/assumptions.h \
  compat/byteswap.h \
  compat/endian.h \
  compat/sanity.h \
  compressor.h \
  consensus/consensus.h \
  consensus/tx_verify.h \
  core_io.h \
  core_memusage.h \
  cuckoocache.h \
  fs.h \
  httprpc.h \
  httpserver.h \
  index/base.h \
  index/txindex.h \
  indirectmap.h \
  init.h \
  interfaces/chain.h \
  interfaces/handler.h \
  interfaces/node.h \
  interfaces/wallet.h \
  key.h \
  key_io.h \
  keystore.h \
  dbwrapper.h \
  limitedmap.h \
  logging.h \
  memusage.h \
  merkleblock.h \
  miner.h \
  net.h \
  net_processing.h \
  netaddress.h \
  netbase.h \
  netmessagemaker.h \
  node/transaction.h \
  noui.h \
  optional.h \
  outputtype.h \
  policy/feerate.h \
  policy/fees.h \
  policy/policy.h \
  policy/rbf.h \
  pow.h \
  protocol.h \
  psbt.h \
  random.h \
  reverse_iterator.h \
  reverselock.h \
  rpc/blockchain.h \
  rpc/client.h \
  rpc/mining.h \
  rpc/protocol.h \
  rpc/server.h \
  rpc/rawtransaction.h \
  rpc/register.h \
  rpc/util.h \
  scheduler.h \
  script/descriptor.h \
  script/ismine.h \
  script/sigcache.h \
  script/sign.h \
  script/standard.h \
  shutdown.h \
  streams.h \
  support/allocators/secure.h \
  support/allocators/zeroafterfree.h \
  support/cleanse.h \
  support/events.h \
  support/lockedpool.h \
  sync.h \
  threadsafety.h \
  threadinterrupt.h \
  timedata.h \
  torcontrol.h \
  txdb.h \
  txmempool.h \
  ui_interface.h \
  undo.h \
  util/bip32.h \
  util/bytevectorhash.h \
  util/system.h \
  util/memory.h \
  util/moneystr.h \
  util/time.h \
  validation.h \
  validationinterface.h \
  versionbits.h \
  versionbitsinfo.h \
  walletinitinterface.h \
  wallet/coincontrol.h \
  wallet/crypter.h \
  wallet/db.h \
  wallet/feebumper.h \
  wallet/fees.h \
  wallet/psbtwallet.h \
  wallet/rpcwallet.h \
  wallet/wallet.h \
  wallet/walletdb.h \
  wallet/wallettool.h \
  wallet/walletutil.h \
  wallet/coinselection.h \
  warnings.h \
  zmq/zmqabstractnotifier.h \
  zmq/zmqconfig.h\
  zmq/zmqnotificationinterface.h \
  zmq/zmqpublishnotifier.h \
  zmq/zmqrpc.h


obj/build.h: FORCE
	@$(MKDIR_P) $(builddir)/obj
	@$(top_srcdir)/share/genbuild.sh "$(abs_top_builddir)/src/obj/build.h" \
	  "$(abs_top_srcdir)"
libignitecoin_util_a-clientversion.$(OBJEXT): obj/build.h

# server: shared between ignitecoind and ignitecoin-qt
libignitecoin_server_a_CPPFLAGS = $(AM_CPPFLAGS) $(IGNITECOIN_INCLUDES) $(MINIUPNPC_CPPFLAGS) $(EVENT_CFLAGS) $(EVENT_PTHREADS_CFLAGS)
libignitecoin_server_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libignitecoin_server_a_SOURCES = \
  addrdb.cpp \
  addrman.cpp \
  banman.cpp \
  bloom.cpp \
  blockencodings.cpp \
  blockfilter.cpp \
  chain.cpp \
  checkpoints.cpp \
  consensus/tx_verify.cpp \
  httprpc.cpp \
  httpserver.cpp \
  index/base.cpp \
  index/txindex.cpp \
  interfaces/chain.cpp \
  interfaces/handler.cpp \
  interfaces/node.cpp \
  init.cpp \
  dbwrapper.cpp \
  merkleblock.cpp \
  miner.cpp \
  net.cpp \
  net_processing.cpp \
  node/transaction.cpp \
  noui.cpp \
  outputtype.cpp \
  policy/fees.cpp \
  policy/policy.cpp \
  policy/rbf.cpp \
  pow.cpp \
  rest.cpp \
  rpc/blockchain.cpp \
  rpc/mining.cpp \
  rpc/misc.cpp \
  rpc/net.cpp \
  rpc/rawtransaction.cpp \
  rpc/server.cpp \
  rpc/util.cpp \
  script/sigcache.cpp \
  shutdown.cpp \
  timedata.cpp \
  torcontrol.cpp \
  txdb.cpp \
  txmempool.cpp \
  ui_interface.cpp \
  validation.cpp \
  validationinterface.cpp \
  versionbits.cpp \
  $(IGNITECOIN_CORE_H)

if !ENABLE_WALLET
libignitecoin_server_a_SOURCES += dummywallet.cpp
endif

if ENABLE_ZMQ
libignitecoin_zmq_a_CPPFLAGS = $(IGNITECOIN_INCLUDES) $(ZMQ_CFLAGS)
libignitecoin_zmq_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libignitecoin_zmq_a_SOURCES = \
  zmq/zmqabstractnotifier.cpp \
  zmq/zmqnotificationinterface.cpp \
  zmq/zmqpublishnotifier.cpp \
  zmq/zmqrpc.cpp
endif


# wallet: shared between ignitecoind and ignitecoin-qt, but only linked
# when wallet enabled
libignitecoin_wallet_a_CPPFLAGS = $(AM_CPPFLAGS) $(IGNITECOIN_INCLUDES)
libignitecoin_wallet_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libignitecoin_wallet_a_SOURCES = \
  interfaces/wallet.cpp \
  wallet/coincontrol.cpp \
  wallet/crypter.cpp \
  wallet/db.cpp \
  wallet/feebumper.cpp \
  wallet/fees.cpp \
  wallet/init.cpp \
  wallet/psbtwallet.cpp \
  wallet/rpcdump.cpp \
  wallet/rpcwallet.cpp \
  wallet/wallet.cpp \
  wallet/walletdb.cpp \
  wallet/walletutil.cpp \
  wallet/coinselection.cpp \
  $(IGNITECOIN_CORE_H)

libignitecoin_wallet_tool_a_CPPFLAGS = $(AM_CPPFLAGS) $(IGNITECOIN_INCLUDES)
libignitecoin_wallet_tool_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libignitecoin_wallet_tool_a_SOURCES = \
  wallet/wallettool.cpp \
  $(IGNITECOIN_CORE_H)

# crypto primitives library
crypto_libignitecoin_crypto_base_a_CPPFLAGS = $(AM_CPPFLAGS)
crypto_libignitecoin_crypto_base_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libignitecoin_crypto_base_a_SOURCES = \
  crypto/aes.cpp \
  crypto/aes.h \
  crypto/chacha20.h \
  crypto/chacha20.cpp \
  crypto/common.h \
  crypto/hmac_sha256.cpp \
  crypto/hmac_sha256.h \
  crypto/hmac_sha512.cpp \
  crypto/hmac_sha512.h \
  crypto/ripemd160.cpp \
  crypto/ripemd160.h \
  crypto/sha1.cpp \
  crypto/sha1.h \
  crypto/sha256.cpp \
  crypto/sha256.h \
  crypto/sha512.cpp \
  crypto/sha512.h \
  crypto/siphash.cpp \
  crypto/siphash.h

if USE_ASM
crypto_libignitecoin_crypto_base_a_SOURCES += crypto/sha256_sse4.cpp
endif

crypto_libignitecoin_crypto_sse41_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libignitecoin_crypto_sse41_a_CPPFLAGS = $(AM_CPPFLAGS)
crypto_libignitecoin_crypto_sse41_a_CXXFLAGS += $(SSE41_CXXFLAGS)
crypto_libignitecoin_crypto_sse41_a_CPPFLAGS += -DENABLE_SSE41
crypto_libignitecoin_crypto_sse41_a_SOURCES = crypto/sha256_sse41.cpp

crypto_libignitecoin_crypto_avx2_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libignitecoin_crypto_avx2_a_CPPFLAGS = $(AM_CPPFLAGS)
crypto_libignitecoin_crypto_avx2_a_CXXFLAGS += $(AVX2_CXXFLAGS)
crypto_libignitecoin_crypto_avx2_a_CPPFLAGS += -DENABLE_AVX2
crypto_libignitecoin_crypto_avx2_a_SOURCES = crypto/sha256_avx2.cpp

crypto_libignitecoin_crypto_shani_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libignitecoin_crypto_shani_a_CPPFLAGS = $(AM_CPPFLAGS)
crypto_libignitecoin_crypto_shani_a_CXXFLAGS += $(SHANI_CXXFLAGS)
crypto_libignitecoin_crypto_shani_a_CPPFLAGS += -DENABLE_SHANI
crypto_libignitecoin_crypto_shani_a_SOURCES = crypto/sha256_shani.cpp

# consensus: shared between all executables that validate any consensus rules.
libignitecoin_consensus_a_CPPFLAGS = $(AM_CPPFLAGS) $(IGNITECOIN_INCLUDES)
libignitecoin_consensus_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libignitecoin_consensus_a_SOURCES = \
  amount.h \
  arith_uint256.cpp \
  arith_uint256.h \
  consensus/merkle.cpp \
  consensus/merkle.h \
  consensus/params.h \
  consensus/validation.h \
  hash.cpp \
  hash.h \
  prevector.h \
  primitives/block.cpp \
  primitives/block.h \
  primitives/transaction.cpp \
  primitives/transaction.h \
  pubkey.cpp \
  pubkey.h \
  script/ignitecoinconsensus.cpp \
  script/interpreter.cpp \
  script/interpreter.h \
  script/script.cpp \
  script/script.h \
  script/script_error.cpp \
  script/script_error.h \
  serialize.h \
  span.h \
  tinyformat.h \
  uint256.cpp \
  uint256.h \
  util/strencodings.cpp \
  util/strencodings.h \
  version.h

# common: shared between ignitecoind, and ignitecoin-qt and non-server tools
libignitecoin_common_a_CPPFLAGS = $(AM_CPPFLAGS) $(IGNITECOIN_INCLUDES)
libignitecoin_common_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libignitecoin_common_a_SOURCES = \
  base58.cpp \
  bech32.cpp \
  chainparams.cpp \
  coins.cpp \
  compressor.cpp \
  core_read.cpp \
  core_write.cpp \
  key.cpp \
  key_io.cpp \
  keystore.cpp \
  netaddress.cpp \
  netbase.cpp \
  policy/feerate.cpp \
  psbt.cpp \
  protocol.cpp \
  scheduler.cpp \
  script/descriptor.cpp \
  script/ismine.cpp \
  script/sign.cpp \
  script/standard.cpp \
  versionbitsinfo.cpp \
  warnings.cpp \
  $(IGNITECOIN_CORE_H)

# util: shared between all executables.
# This library *must* be included to make sure that the glibc
# backward-compatibility objects and their sanity checks are linked.
libignitecoin_util_a_CPPFLAGS = $(AM_CPPFLAGS) $(IGNITECOIN_INCLUDES)
libignitecoin_util_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libignitecoin_util_a_SOURCES = \
  support/lockedpool.cpp \
  chainparamsbase.cpp \
  clientversion.cpp \
  compat/glibc_sanity.cpp \
  compat/glibcxx_sanity.cpp \
  compat/strnlen.cpp \
  fs.cpp \
  logging.cpp \
  random.cpp \
  rpc/protocol.cpp \
  support/cleanse.cpp \
  sync.cpp \
  threadinterrupt.cpp \
  util/bip32.cpp \
  util/bytevectorhash.cpp \
  util/system.cpp \
  util/moneystr.cpp \
  util/strencodings.cpp \
  util/time.cpp \
  $(IGNITECOIN_CORE_H)

if GLIBC_BACK_COMPAT
libignitecoin_util_a_SOURCES += compat/glibc_compat.cpp
AM_LDFLAGS += $(COMPAT_LDFLAGS)
endif

# cli: shared between ignitecoin-cli and ignitecoin-qt
libignitecoin_cli_a_CPPFLAGS = $(AM_CPPFLAGS) $(IGNITECOIN_INCLUDES)
libignitecoin_cli_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libignitecoin_cli_a_SOURCES = \
  rpc/client.cpp \
  $(IGNITECOIN_CORE_H)

nodist_libignitecoin_util_a_SOURCES = $(srcdir)/obj/build.h
#

# ignitecoind binary #
ignitecoind_SOURCES = ignitecoind.cpp
ignitecoind_CPPFLAGS = $(AM_CPPFLAGS) $(IGNITECOIN_INCLUDES)
ignitecoind_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
ignitecoind_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
ignitecoind_SOURCES += ignitecoind-res.rc
endif

ignitecoind_LDADD = \
  $(LIBIGNITECOIN_SERVER) \
  $(LIBIGNITECOIN_WALLET) \
  $(LIBIGNITECOIN_SERVER) \
  $(LIBIGNITECOIN_COMMON) \
  $(LIBUNIVALUE) \
  $(LIBIGNITECOIN_UTIL) \
  $(LIBIGNITECOIN_ZMQ) \
  $(LIBIGNITECOIN_CONSENSUS) \
  $(LIBIGNITECOIN_CRYPTO) \
  $(LIBLEVELDB) \
  $(LIBLEVELDB_SSE42) \
  $(LIBMEMENV) \
  $(LIBSECP256K1)

ignitecoind_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(CRYPTO_LIBS) $(MINIUPNPC_LIBS) $(EVENT_PTHREADS_LIBS) $(EVENT_LIBS) $(ZMQ_LIBS)

# ignitecoin-cli binary #
ignitecoin_cli_SOURCES = ignitecoin-cli.cpp
ignitecoin_cli_CPPFLAGS = $(AM_CPPFLAGS) $(IGNITECOIN_INCLUDES) $(EVENT_CFLAGS)
ignitecoin_cli_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
ignitecoin_cli_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
ignitecoin_cli_SOURCES += ignitecoin-cli-res.rc
endif

ignitecoin_cli_LDADD = \
  $(LIBIGNITECOIN_CLI) \
  $(LIBUNIVALUE) \
  $(LIBIGNITECOIN_UTIL) \
  $(LIBIGNITECOIN_CRYPTO)

ignitecoin_cli_LDADD += $(BOOST_LIBS) $(CRYPTO_LIBS) $(EVENT_LIBS)
#

# ignitecoin-tx binary #
ignitecoin_tx_SOURCES = ignitecoin-tx.cpp
ignitecoin_tx_CPPFLAGS = $(AM_CPPFLAGS) $(IGNITECOIN_INCLUDES)
ignitecoin_tx_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
ignitecoin_tx_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
ignitecoin_tx_SOURCES += ignitecoin-tx-res.rc
endif

ignitecoin_tx_LDADD = \
  $(LIBUNIVALUE) \
  $(LIBIGNITECOIN_COMMON) \
  $(LIBIGNITECOIN_UTIL) \
  $(LIBIGNITECOIN_CONSENSUS) \
  $(LIBIGNITECOIN_CRYPTO) \
  $(LIBSECP256K1)

ignitecoin_tx_LDADD += $(BOOST_LIBS) $(CRYPTO_LIBS)
#

# ignitecoin-wallet binary #
ignitecoin_wallet_SOURCES = ignitecoin-wallet.cpp
ignitecoin_wallet_CPPFLAGS = $(AM_CPPFLAGS) $(IGNITECOIN_INCLUDES)
ignitecoin_wallet_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
ignitecoin_wallet_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
ignitecoin_wallet_SOURCES += ignitecoin-wallet-res.rc
endif

ignitecoin_wallet_LDADD = \
  $(LIBIGNITECOIN_WALLET_TOOL) \
  $(LIBIGNITECOIN_WALLET) \
  $(LIBIGNITECOIN_SERVER) \
  $(LIBIGNITECOIN_COMMON) \
  $(LIBIGNITECOIN_CONSENSUS) \
  $(LIBIGNITECOIN_UTIL) \
  $(LIBIGNITECOIN_CRYPTO) \
  $(LIBLEVELDB) \
  $(LIBLEVELDB_SSE42) \
  $(LIBMEMENV) \
  $(LIBSECP256K1)

ignitecoin_wallet_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(CRYPTO_LIBS) $(MINIUPNPC_LIBS)
#

# ignitecoinconsensus library #
if BUILD_IGNITECOIN_LIBS
include_HEADERS = script/ignitecoinconsensus.h
libignitecoinconsensus_la_SOURCES = $(crypto_libignitecoin_crypto_base_a_SOURCES) $(libignitecoin_consensus_a_SOURCES)

if GLIBC_BACK_COMPAT
  libignitecoinconsensus_la_SOURCES += compat/glibc_compat.cpp
endif

libignitecoinconsensus_la_LDFLAGS = $(AM_LDFLAGS) -no-undefined $(RELDFLAGS)
libignitecoinconsensus_la_LIBADD = $(LIBSECP256K1)
libignitecoinconsensus_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(builddir)/obj -I$(srcdir)/secp256k1/include -DBUILD_IGNITECOIN_INTERNAL
libignitecoinconsensus_la_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)

endif
#

CTAES_DIST =  crypto/ctaes/bench.c
CTAES_DIST += crypto/ctaes/ctaes.c
CTAES_DIST += crypto/ctaes/ctaes.h
CTAES_DIST += crypto/ctaes/README.md
CTAES_DIST += crypto/ctaes/test.c

CLEANFILES = $(EXTRA_LIBRARIES)

CLEANFILES += *.gcda *.gcno
CLEANFILES += compat/*.gcda compat/*.gcno
CLEANFILES += consensus/*.gcda consensus/*.gcno
CLEANFILES += crypto/*.gcda crypto/*.gcno
CLEANFILES += policy/*.gcda policy/*.gcno
CLEANFILES += primitives/*.gcda primitives/*.gcno
CLEANFILES += script/*.gcda script/*.gcno
CLEANFILES += support/*.gcda support/*.gcno
CLEANFILES += univalue/*.gcda univalue/*.gcno
CLEANFILES += wallet/*.gcda wallet/*.gcno
CLEANFILES += wallet/test/*.gcda wallet/test/*.gcno
CLEANFILES += zmq/*.gcda zmq/*.gcno
CLEANFILES += obj/build.h

EXTRA_DIST = $(CTAES_DIST)


config/ignitecoin-config.h: config/stamp-h1
	@$(MAKE) -C $(top_builddir) $(subdir)/$(@)
config/stamp-h1: $(top_srcdir)/$(subdir)/config/ignitecoin-config.h.in $(top_builddir)/config.status
	$(AM_V_at)$(MAKE) -C $(top_builddir) $(subdir)/$(@)
$(top_srcdir)/$(subdir)/config/ignitecoin-config.h.in:  $(am__configure_deps)
	$(AM_V_at)$(MAKE) -C $(top_srcdir) $(subdir)/config/ignitecoin-config.h.in

clean-local:
	-$(MAKE) -C secp256k1 clean
	-$(MAKE) -C univalue clean
	-rm -f leveldb/*/*.gcda leveldb/*/*.gcno leveldb/helpers/memenv/*.gcda leveldb/helpers/memenv/*.gcno
	-rm -f config.h
	-rm -rf test/__pycache__

.rc.o:
	@test -f $(WINDRES)
	## FIXME: How to get the appropriate modulename_CPPFLAGS in here?
	$(AM_V_GEN) $(WINDRES) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(CPPFLAGS) -DWINDRES_PREPROC -i $< -o $@

check-symbols: $(bin_PROGRAMS)
if GLIBC_BACK_COMPAT
	@echo "Checking glibc back compat..."
	$(AM_V_at) READELF=$(READELF) CPPFILT=$(CPPFILT) $(top_srcdir)/contrib/devtools/symbol-check.py $(bin_PROGRAMS)
endif

check-security: $(bin_PROGRAMS)
if HARDEN
	@echo "Checking binary security..."
	$(AM_V_at) READELF=$(READELF) OBJDUMP=$(OBJDUMP) $(top_srcdir)/contrib/devtools/security-check.py $(bin_PROGRAMS)
endif

if ENABLE_BIP70
%.pb.cc %.pb.h: %.proto
	@test -f $(PROTOC)
	$(AM_V_GEN) $(PROTOC) --cpp_out=$(@D) --proto_path=$(<D) $<
endif

if EMBEDDED_LEVELDB
include Makefile.leveldb.include
endif

if ENABLE_TESTS
include Makefile.test.include
endif

if ENABLE_BENCH
include Makefile.bench.include
endif

if ENABLE_QT
include Makefile.qt.include
endif

if ENABLE_QT_TESTS
include Makefile.qttest.include
endif
