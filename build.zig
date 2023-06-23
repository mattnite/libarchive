const std = @import("std");
const Build = std.Build;

pub fn build(b: *Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const libarchive = b.addStaticLibrary(.{
        .name = "archive",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });
    b.installArtifact(libarchive);
    libarchive.addCSourceFiles(libarchive_srcs, &.{});
    libarchive.defineCMacro("HAVE_CONFIG_H", null);
    libarchive.installHeader("libarchive/archive.h", "archive.h");

    const os_tag = target.getOsTag();

    if (os_tag == .macos)
        libarchive.linkFramework("CommonCrypto");

    const config_header = b.addConfigHeader(.{
        .style = .{ .cmake = .{ .path = "build/cmake/config.h.in" } },
        .include_path = "config.h",
    }, .{
        .VERSION = "3.6.2",

        // * Some platform requires a macro to use extension functions.
        .SAFE_TO_DEFINE_EXTENSIONS = 1, //@_FILE_OFFSET_BITS@
        //* Number of bits in a file offset, on hosts where this is settable. */
        ._FILE_OFFSET_BITS = 1,
        //* Define to 1 to make fseeko visible on some hosts (e.g. glibc 2.2). */
        ._LARGEFILE_SOURCE = 1,
        //* Define for large files, on AIX-style hosts. */
        ._LARGE_FILES = 1, //@_LARGE_FILES@
        //* Define to control Windows SDK version */
        .NTDDI_VERSION = 1, //@NTDDI_VERSION@
        ._WIN32_WINNT = 1, // @_WIN32_WINNT@
        .WINVER = "<winver>",

        .HAVE_INT16_T = {},
        .HAVE_INT32_T = {},
        .HAVE_INT64_T = {},
        .HAVE_INTMAX_T = {},
        .HAVE_UINT8_T = {},
        .HAVE_UINT16_T = {},
        .HAVE_UINT32_T = {},
        .HAVE_UINT64_T = {},
        .HAVE_UINTMAX_T = {},
        .HAVE___INT64 = {},
        .HAVE_U_INT64_T = {},
        .HAVE_UNSIGNED___INT64 = {},

        // Define ZLIB_WINAPI if zlib was built on Visual Studio.
        .ZLIB_WINAPI = null,

        // Darwin ACL support
        .ARCHIVE_ACL_DARWIN = null,

        // FreeBSD ACL support
        .ARCHIVE_ACL_FREEBSD = null,

        // FreeBSD NFSv4 ACL support
        .ARCHIVE_ACL_FREEBSD_NFS4 = null,

        // Linux POSIX.1e ACL support via libacl
        .ARCHIVE_ACL_LIBACL = null,

        // Linux NFSv4 ACL support via librichacl
        .ARCHIVE_ACL_LIBRICHACL = null,

        // Solaris ACL support
        .ARCHIVE_ACL_SUNOS = null,

        // Solaris NFSv4 ACL support
        .ARCHIVE_ACL_SUNOS_NFS4 = null,

        // MD5 via ARCHIVE_CRYPTO_MD5_LIBC supported.
        .ARCHIVE_CRYPTO_MD5_LIBC = null,

        // MD5 via ARCHIVE_CRYPTO_MD5_LIBSYSTEM supported.
        .ARCHIVE_CRYPTO_MD5_LIBSYSTEM = null,

        // MD5 via ARCHIVE_CRYPTO_MD5_NETTLE supported.
        .ARCHIVE_CRYPTO_MD5_NETTLE = null,

        // MD5 via ARCHIVE_CRYPTO_MD5_OPENSSL supported.
        .ARCHIVE_CRYPTO_MD5_OPENSSL = null,

        // MD5 via ARCHIVE_CRYPTO_MD5_WIN supported.
        .ARCHIVE_CRYPTO_MD5_WIN = null,

        // RMD160 via ARCHIVE_CRYPTO_RMD160_LIBC supported.
        .ARCHIVE_CRYPTO_RMD160_LIBC = null,

        // RMD160 via ARCHIVE_CRYPTO_RMD160_NETTLE supported.
        .ARCHIVE_CRYPTO_RMD160_NETTLE = null,

        // RMD160 via ARCHIVE_CRYPTO_RMD160_OPENSSL supported.
        .ARCHIVE_CRYPTO_RMD160_OPENSSL = null,

        // SHA1 via ARCHIVE_CRYPTO_SHA1_LIBC supported.
        .ARCHIVE_CRYPTO_SHA1_LIBC = null,

        // SHA1 via ARCHIVE_CRYPTO_SHA1_LIBSYSTEM supported.
        .ARCHIVE_CRYPTO_SHA1_LIBSYSTEM = null,

        // SHA1 via ARCHIVE_CRYPTO_SHA1_NETTLE supported.
        .ARCHIVE_CRYPTO_SHA1_NETTLE = null,

        // SHA1 via ARCHIVE_CRYPTO_SHA1_OPENSSL supported.
        .ARCHIVE_CRYPTO_SHA1_OPENSSL = null,

        // SHA1 via ARCHIVE_CRYPTO_SHA1_WIN supported.
        .ARCHIVE_CRYPTO_SHA1_WIN = null,

        // SHA256 via ARCHIVE_CRYPTO_SHA256_LIBC supported.
        .ARCHIVE_CRYPTO_SHA256_LIBC = null,

        // SHA256 via ARCHIVE_CRYPTO_SHA256_LIBC2 supported.
        .ARCHIVE_CRYPTO_SHA256_LIBC2 = null,

        // SHA256 via ARCHIVE_CRYPTO_SHA256_LIBC3 supported.
        .ARCHIVE_CRYPTO_SHA256_LIBC3 = null,

        // SHA256 via ARCHIVE_CRYPTO_SHA256_LIBSYSTEM supported.
        .ARCHIVE_CRYPTO_SHA256_LIBSYSTEM = null,

        // SHA256 via ARCHIVE_CRYPTO_SHA256_NETTLE supported.
        .ARCHIVE_CRYPTO_SHA256_NETTLE = null,

        // SHA256 via ARCHIVE_CRYPTO_SHA256_OPENSSL supported.
        .ARCHIVE_CRYPTO_SHA256_OPENSSL = null,

        // SHA256 via ARCHIVE_CRYPTO_SHA256_WIN supported.
        .ARCHIVE_CRYPTO_SHA256_WIN = null,

        // SHA384 via ARCHIVE_CRYPTO_SHA384_LIBC supported.
        .ARCHIVE_CRYPTO_SHA384_LIBC = null,

        // SHA384 via ARCHIVE_CRYPTO_SHA384_LIBC2 supported.
        .ARCHIVE_CRYPTO_SHA384_LIBC2 = null,

        // SHA384 via ARCHIVE_CRYPTO_SHA384_LIBC3 supported.
        .ARCHIVE_CRYPTO_SHA384_LIBC3 = null,

        // SHA384 via ARCHIVE_CRYPTO_SHA384_LIBSYSTEM supported.
        .ARCHIVE_CRYPTO_SHA384_LIBSYSTEM = null,

        // SHA384 via ARCHIVE_CRYPTO_SHA384_NETTLE supported.
        .ARCHIVE_CRYPTO_SHA384_NETTLE = null,

        // SHA384 via ARCHIVE_CRYPTO_SHA384_OPENSSL supported.
        .ARCHIVE_CRYPTO_SHA384_OPENSSL = null,

        // SHA384 via ARCHIVE_CRYPTO_SHA384_WIN supported.
        .ARCHIVE_CRYPTO_SHA384_WIN = null,

        // SHA512 via ARCHIVE_CRYPTO_SHA512_LIBC supported.
        .ARCHIVE_CRYPTO_SHA512_LIBC = null,

        // SHA512 via ARCHIVE_CRYPTO_SHA512_LIBC2 supported.
        .ARCHIVE_CRYPTO_SHA512_LIBC2 = null,

        // SHA512 via ARCHIVE_CRYPTO_SHA512_LIBC3 supported.
        .ARCHIVE_CRYPTO_SHA512_LIBC3 = null,

        // SHA512 via ARCHIVE_CRYPTO_SHA512_LIBSYSTEM supported.
        .ARCHIVE_CRYPTO_SHA512_LIBSYSTEM = null,

        // SHA512 via ARCHIVE_CRYPTO_SHA512_NETTLE supported.
        .ARCHIVE_CRYPTO_SHA512_NETTLE = null,

        // SHA512 via ARCHIVE_CRYPTO_SHA512_OPENSSL supported.
        .ARCHIVE_CRYPTO_SHA512_OPENSSL = null,

        // SHA512 via ARCHIVE_CRYPTO_SHA512_WIN supported.
        .ARCHIVE_CRYPTO_SHA512_WIN = null,

        // AIX xattr support
        .ARCHIVE_XATTR_AIX = null,

        // Darwin xattr support
        .ARCHIVE_XATTR_DARWIN = null,

        // FreeBSD xattr support
        .ARCHIVE_XATTR_FREEBSD = null,

        // Linux xattr support
        .ARCHIVE_XATTR_LINUX = null,

        // Version number of bsdcpio
        .BSDCPIO_VERSION_STRING = "@BSDCPIO_VERSION_STRING@",

        // Version number of bsdtar
        .BSDTAR_VERSION_STRING = "@BSDTAR_VERSION_STRING@",

        // Version number of bsdcat
        .BSDCAT_VERSION_STRING = "@BSDCAT_VERSION_STRING@",

        // Define to 1 if you have the `acl_create_entry' function.
        .HAVE_ACL_CREATE_ENTRY = null,

        // Define to 1 if you have the `acl_get_fd_np' function.
        .HAVE_ACL_GET_FD_NP = null,

        // Define to 1 if you have the `acl_get_link' function.
        .HAVE_ACL_GET_LINK = null,

        // Define to 1 if you have the `acl_get_link_np' function.
        .HAVE_ACL_GET_LINK_NP = null,

        // Define to 1 if you have the `acl_get_perm' function.
        .HAVE_ACL_GET_PERM = null,

        // Define to 1 if you have the `acl_get_perm_np' function.
        .HAVE_ACL_GET_PERM_NP = null,

        // Define to 1 if you have the `acl_init' function.
        .HAVE_ACL_INIT = null,

        // Define to 1 if you have the <acl/libacl.h> header file.
        .HAVE_ACL_LIBACL_H = null,

        // Define to 1 if the system has the type `acl_permset_t'.
        .HAVE_ACL_PERMSET_T = null,

        // Define to 1 if you have the `acl_set_fd' function.
        .HAVE_ACL_SET_FD = null,

        // Define to 1 if you have the `acl_set_fd_np' function.
        .HAVE_ACL_SET_FD_NP = null,

        // Define to 1 if you have the `acl_set_file' function.
        .HAVE_ACL_SET_FILE = null,

        // Define to 1 if you have the `arc4random_buf' function.
        .HAVE_ARC4RANDOM_BUF = 1,

        // Define to 1 if you have the <attr/xattr.h> header file.
        .HAVE_ATTR_XATTR_H = null,

        // Define to 1 if you have the <Bcrypt.h> header file.
        .HAVE_BCRYPT_H = 1,

        // Define to 1 if you have the <bsdxml.h> header file.
        .HAVE_BSDXML_H = null,

        // Define to 1 if you have the <bzlib.h> header file.
        .HAVE_BZLIB_H = null,

        // Define to 1 if you have the `chflags' function.
        .HAVE_CHFLAGS = 1,

        // Define to 1 if you have the `chown' function.
        .HAVE_CHOWN = 1,

        // Define to 1 if you have the `chroot' function.
        .HAVE_CHROOT = 1,

        // Define to 1 if you have the <copyfile.h> header file.
        .HAVE_COPYFILE_H = 1,

        // Define to 1 if you have the `ctime_r' function.
        .HAVE_CTIME_R = 1,

        // Define to 1 if you have the <ctype.h> header file.
        .HAVE_CTYPE_H = 1,

        // Define to 1 if you have the `cygwin_conv_path' function.
        .HAVE_CYGWIN_CONV_PATH = 1,

        // Define to 1 if you have the declaration of `ACE_GETACL', and to 0 if you don't.
        .HAVE_DECL_ACE_GETACL = 1,

        // Define to 1 if you have the declaration of `ACE_GETACLCNT', and to 0 if you don't.
        .HAVE_DECL_ACE_GETACLCNT = 1,

        // Define to 1 if you have the declaration of `ACE_SETACL', and to 0 if you don't.
        .HAVE_DECL_ACE_SETACL = 1,

        // Define to 1 if you have the declaration of `ACL_SYNCHRONIZE', and to 0 if you don't.
        .HAVE_DECL_ACL_SYNCHRONIZE = null,

        // Define to 1 if you have the declaration of `ACL_TYPE_EXTENDED', and to 0 if you don't.
        .HAVE_DECL_ACL_TYPE_EXTENDED = null,

        // Define to 1 if you have the declaration of `ACL_TYPE_NFS4', and to 0 if you don't.
        .HAVE_DECL_ACL_TYPE_NFS4 = null,

        // Define to 1 if you have the declaration of `ACL_USER', and to 0 if you don't.
        .HAVE_DECL_ACL_USER = null,

        // Define to 1 if you have the declaration of `INT32_MAX', and to 0 if you don't.
        .HAVE_DECL_INT32_MAX = 1,

        // Define to 1 if you have the declaration of `INT32_MIN', and to 0 if you don't.
        .HAVE_DECL_INT32_MIN = 1,

        // Define to 1 if you have the declaration of `INT64_MAX', and to 0 if you don't.
        .HAVE_DECL_INT64_MAX = 1,

        // Define to 1 if you have the declaration of `INT64_MIN', and to 0 if you don't.
        .HAVE_DECL_INT64_MIN = 1,

        // Define to 1 if you have the declaration of `INTMAX_MAX', and to 0 if you don't.
        .HAVE_DECL_INTMAX_MAX = 1,

        // Define to 1 if you have the declaration of `INTMAX_MIN', and to 0 if you don't.
        .HAVE_DECL_INTMAX_MIN = 1,

        // Define to 1 if you have the declaration of `SETACL', and to 0 if you don't.
        .HAVE_DECL_SETACL = 1,

        // Define to 1 if you have the declaration of `SIZE_MAX', and to 0 if you don't.
        .HAVE_DECL_SIZE_MAX = 1,

        // Define to 1 if you have the declaration of `SSIZE_MAX', and to 0 if you don't.
        .HAVE_DECL_SSIZE_MAX = 1,

        // Define to 1 if you have the declaration of `strerror_r', and to 0 if you don't.
        .HAVE_DECL_STRERROR_R = 1,

        // Define to 1 if you have the declaration of `UINT32_MAX', and to 0 if you don't.
        .HAVE_DECL_UINT32_MAX = 1,

        // Define to 1 if you have the declaration of `UINT64_MAX', and to 0 if you don't.
        .HAVE_DECL_UINT64_MAX = 1,

        // Define to 1 if you have the declaration of `UINTMAX_MAX', and to 0 if you don't.
        .HAVE_DECL_UINTMAX_MAX = 1,

        // Define to 1 if you have the declaration of `XATTR_NOFOLLOW', and to 0 if you don't.
        .HAVE_DECL_XATTR_NOFOLLOW = 1,

        // Define to 1 if you have the <direct.h> header file.
        .HAVE_DIRECT_H = null,

        // Define to 1 if you have the <dirent.h> header file, and it defines `DIR'.
        .HAVE_DIRENT_H = 1,

        // Define to 1 if you have the `dirfd' function.
        .HAVE_DIRFD = 1,

        // Define to 1 if you have the <dlfcn.h> header file.
        .HAVE_DLFCN_H = 1,

        // Define to 1 if you don't have `vprintf' but do have `_doprnt.'
        .HAVE_DOPRNT = 1,

        // Define to 1 if nl_langinfo supports D_MD_ORDER
        .HAVE_D_MD_ORDER = 1,

        // A possible errno value for invalid file format errors
        .HAVE_EFTYPE = 1,

        // A possible errno value for invalid file format errors
        .HAVE_EILSEQ = 1,

        // Define to 1 if you have the <errno.h> header file.
        .HAVE_ERRNO_H = 1,

        // Define to 1 if you have the <expat.h> header file.
        .HAVE_EXPAT_H = null,

        // Define to 1 if you have the <ext2fs/ext2_fs.h> header file.
        .HAVE_EXT2FS_EXT2_FS_H = null,

        // Define to 1 if you have the `extattr_get_file' function.
        .HAVE_EXTATTR_GET_FILE = 1,

        // Define to 1 if you have the `extattr_list_file' function.
        .HAVE_EXTATTR_LIST_FILE = 1,

        // Define to 1 if you have the `extattr_set_fd' function.
        .HAVE_EXTATTR_SET_FD = 1,

        // Define to 1 if you have the `extattr_set_file' function.
        .HAVE_EXTATTR_SET_FILE = 1,

        // Define to 1 if EXTATTR_NAMESPACE_USER is defined in sys/extattr.h.
        .HAVE_DECL_EXTATTR_NAMESPACE_USER = 1,

        // Define to 1 if you have the declaration of `GETACL', and to 0 if you don't.
        .HAVE_DECL_GETACL = 1,

        // Define to 1 if you have the declaration of `GETACLCNT', and to 0 if you don't.
        .HAVE_DECL_GETACLCNT = 1,

        // Define to 1 if you have the `fchdir' function.
        .HAVE_FCHDIR = 1,

        // Define to 1 if you have the `fchflags' function.
        .HAVE_FCHFLAGS = 1,

        // Define to 1 if you have the `fchmod' function.
        .HAVE_FCHMOD = 1,

        // Define to 1 if you have the `fchown' function.
        .HAVE_FCHOWN = 1,

        // Define to 1 if you have the `fcntl' function.
        .HAVE_FCNTL = 1,

        // Define to 1 if you have the <fcntl.h> header file.
        .HAVE_FCNTL_H = 1,

        // Define to 1 if you have the `fdopendir' function.
        .HAVE_FDOPENDIR = 1,

        // Define to 1 if you have the `fgetea' function.
        .HAVE_FGETEA = 1,

        // Define to 1 if you have the `fgetxattr' function.
        .HAVE_FGETXATTR = 1,

        // Define to 1 if you have the `flistea' function.
        .HAVE_FLISTEA = 1,

        // Define to 1 if you have the `flistxattr' function.
        .HAVE_FLISTXATTR = 1,

        // Define to 1 if you have the `fork' function.
        .HAVE_FORK = 1,

        // Define to 1 if fseeko (and presumably ftello) exists and is declared.
        .HAVE_FSEEKO = 1,

        // Define to 1 if you have the `fsetea' function.
        .HAVE_FSETEA = 1,

        // Define to 1 if you have the `fsetxattr' function.
        .HAVE_FSETXATTR = 1,

        // Define to 1 if you have the `fstat' function.
        .HAVE_FSTAT = 1,

        // Define to 1 if you have the `fstatat' function.
        .HAVE_FSTATAT = 1,

        // Define to 1 if you have the `fstatfs' function.
        .HAVE_FSTATFS = null,

        // Define to 1 if you have the `fstatvfs' function.
        .HAVE_FSTATVFS = 1,

        // Define to 1 if you have the `ftruncate' function.
        .HAVE_FTRUNCATE = 1,

        // Define to 1 if you have the `futimens' function.
        .HAVE_FUTIMENS = 1,

        // Define to 1 if you have the `futimes' function.
        .HAVE_FUTIMES = 1,

        // Define to 1 if you have the `futimesat' function.
        .HAVE_FUTIMESAT = null,

        // Define to 1 if you have the `getea' function.
        .HAVE_GETEA = 1,

        // Define to 1 if you have the `geteuid' function.
        .HAVE_GETEUID = 1,

        // Define to 1 if you have the `getgrgid_r' function.
        .HAVE_GETGRGID_R = 1,

        // Define to 1 if you have the `getgrnam_r' function.
        .HAVE_GETGRNAM_R = 1,

        // Define to 1 if you have the `getpid' function.
        .HAVE_GETPID = 1,

        // Define to 1 if you have the `getpwnam_r' function.
        .HAVE_GETPWNAM_R = 1,

        // Define to 1 if you have the `getpwuid_r' function.
        .HAVE_GETPWUID_R = 1,

        // Define to 1 if you have the `getvfsbyname' function.
        .HAVE_GETVFSBYNAME = 1,

        // Define to 1 if you have the `getxattr' function.
        .HAVE_GETXATTR = 1,

        // Define to 1 if you have the `gmtime_r' function.
        .HAVE_GMTIME_R = 1,

        // Define to 1 if you have the <grp.h> header file.
        .HAVE_GRP_H = 1,

        // Define to 1 if you have the `iconv' function.
        .HAVE_ICONV = null,

        // Define to 1 if you have the <iconv.h> header file.
        .HAVE_ICONV_H = null,

        // Define to 1 if you have the <inttypes.h> header file.
        .HAVE_INTTYPES_H = 1,

        // Define to 1 if you have the <io.h> header file.
        .HAVE_IO_H = null,

        // Define to 1 if you have the <langinfo.h> header file.
        .HAVE_LANGINFO_H = 1,

        // Define to 1 if you have the `lchflags' function.
        .HAVE_LCHFLAGS = 1,

        // Define to 1 if you have the `lchmod' function.
        .HAVE_LCHMOD = 1,

        // Define to 1 if you have the `lchown' function.
        .HAVE_LCHOWN = 1,

        // Define to 1 if you have the `lgetea' function.
        .HAVE_LGETEA = 1,

        // Define to 1 if you have the `lgetxattr' function.
        .HAVE_LGETXATTR = 1,

        // Define to 1 if you have the `acl' library (-lacl).
        .HAVE_LIBACL = 1,

        // Define to 1 if you have the `attr' library (-lattr).
        .HAVE_LIBATTR = 1,

        // Define to 1 if you have the `bsdxml' library (-lbsdxml).
        .HAVE_LIBBSDXML = 1,

        // Define to 1 if you have the `bz2' library (-lbz2).
        .HAVE_LIBBZ2 = 1,

        // Define to 1 if you have the `b2' library (-lb2).
        .HAVE_LIBB2 = 1,

        // Define to 1 if you have the <blake2.h> header file.
        .HAVE_BLAKE2_H = null,

        // Define to 1 if you have the `charset' library (-lcharset).
        .HAVE_LIBCHARSET = 1,

        // Define to 1 if you have the `crypto' library (-lcrypto).
        .HAVE_LIBCRYPTO = 1,

        // Define to 1 if you have the `expat' library (-lexpat).
        .HAVE_LIBEXPAT = 1,

        // Define to 1 if you have the `gcc' library (-lgcc).
        .HAVE_LIBGCC = 1,

        // Define to 1 if you have the `lz4' library (-llz4).
        .HAVE_LIBLZ4 = null,

        // Define to 1 if you have the `lzma' library (-llzma).
        .HAVE_LIBLZMA = null,

        // Define to 1 if you have the `lzmadec' library (-llzmadec).
        .HAVE_LIBLZMADEC = null,

        // Define to 1 if you have the `lzo2' library (-llzo2).
        .HAVE_LIBLZO2 = null,

        // Define to 1 if you have the `mbedcrypto' library (-lmbedcrypto).
        .HAVE_LIBMBEDCRYPTO = null,

        // Define to 1 if you have the `nettle' library (-lnettle).
        .HAVE_LIBNETTLE = null,

        // Define to 1 if you have the `pcre' library (-lpcre).
        .HAVE_LIBPCRE = null,

        // Define to 1 if you have the `pcreposix' library (-lpcreposix).
        .HAVE_LIBPCREPOSIX = null,

        // Define to 1 if you have the `xml2' library (-lxml2).
        .HAVE_LIBXML2 = null,

        // Define to 1 if you have the <libxml/xmlreader.h> header file.
        .HAVE_LIBXML_XMLREADER_H = null,

        // Define to 1 if you have the <libxml/xmlwriter.h> header file.
        .HAVE_LIBXML_XMLWRITER_H = null,

        // Define to 1 if you have the `z' library (-lz).
        .HAVE_LIBZ = null,

        // Define to 1 if you have the `zstd' library (-lzstd).
        .HAVE_LIBZSTD = null,

        // Define to 1 if you have the `zstd' library (-lzstd) with compression support.
        .HAVE_LIBZSTD_COMPRESSOR = null,

        // Define to 1 if you have the <limits.h> header file.
        .HAVE_LIMITS_H = 1,

        // Define to 1 if you have the `link' function.
        .HAVE_LINK = 1,

        // Define to 1 if you have the `linkat' function.
        .HAVE_LINKAT = 1,

        // Define to 1 if you have the <linux/fiemap.h> header file.
        .HAVE_LINUX_FIEMAP_H = null,

        // Define to 1 if you have the <linux/fs.h> header file.
        .HAVE_LINUX_FS_H = null,

        // Define to 1 if you have the <linux/magic.h> header file.
        .HAVE_LINUX_MAGIC_H = null,

        // Define to 1 if you have the <linux/types.h> header file.
        .HAVE_LINUX_TYPES_H = null,

        // Define to 1 if you have the `listea' function.
        .HAVE_LISTEA = 1,

        // Define to 1 if you have the `listxattr' function.
        .HAVE_LISTXATTR = 1,

        // Define to 1 if you have the `llistea' function.
        .HAVE_LLISTEA = 1,

        // Define to 1 if you have the `llistxattr' function.
        .HAVE_LLISTXATTR = 1,

        // Define to 1 if you have the <localcharset.h> header file.
        .HAVE_LOCALCHARSET_H = null,

        // Define to 1 if you have the `locale_charset' function.
        .HAVE_LOCALE_CHARSET = 1,

        // Define to 1 if you have the <locale.h> header file.
        .HAVE_LOCALE_H = 1,

        // Define to 1 if you have the `localtime_r' function.
        .HAVE_LOCALTIME_R = 1,

        // Define to 1 if the system has the type `long long int'.
        .HAVE_LONG_LONG_INT = 1,

        // Define to 1 if you have the `lsetea' function.
        .HAVE_LSETEA = 1,

        // Define to 1 if you have the `lsetxattr' function.
        .HAVE_LSETXATTR = 1,

        // Define to 1 if you have the `lstat' function.
        .HAVE_LSTAT = 1,

        // Define to 1 if `lstat' has the bug that it succeeds when given the zero-length file name argument.
        .HAVE_LSTAT_EMPTY_STRING_BUG = 1,

        // Define to 1 if you have the `lutimes' function.
        .HAVE_LUTIMES = 1,

        // Define to 1 if you have the <lz4hc.h> header file.
        .HAVE_LZ4HC_H = null,

        // Define to 1 if you have the <lz4.h> header file.
        .HAVE_LZ4_H = null,

        // Define to 1 if you have the <lzmadec.h> header file.
        .HAVE_LZMADEC_H = null,

        // Define to 1 if you have the <lzma.h> header file.
        .HAVE_LZMA_H = null,

        // Define to 1 if you have a working `lzma_stream_encoder_mt' function.
        .HAVE_LZMA_STREAM_ENCODER_MT = null,

        // Define to 1 if you have the <lzo/lzo1x.h> header file.
        .HAVE_LZO_LZO1X_H = null,

        // Define to 1 if you have the <lzo/lzoconf.h> header file.
        .HAVE_LZO_LZOCONF_H = null,

        // Define to 1 if you have the `mbrtowc' function.
        .HAVE_MBRTOWC = 1,

        // Define to 1 if you have the <membership.h> header file.
        .HAVE_MEMBERSHIP_H = 1,

        // Define to 1 if you have the `memmove' function.
        .HAVE_MEMMOVE = 1,

        // Define to 1 if you have the <memory.h> header file.
        .HAVE_MEMORY_H = 1,

        // Define to 1 if you have the `mkdir' function.
        .HAVE_MKDIR = 1,

        // Define to 1 if you have the `mkfifo' function.
        .HAVE_MKFIFO = 1,

        // Define to 1 if you have the `mknod' function.
        .HAVE_MKNOD = 1,

        // Define to 1 if you have the `mkstemp' function.
        .HAVE_MKSTEMP = 1,

        // Define to 1 if you have the <ndir.h> header file, and it defines `DIR'.
        .HAVE_NDIR_H = 1,

        // Define to 1 if you have the <nettle/aes.h> header file.
        .HAVE_NETTLE_AES_H = 1,

        // Define to 1 if you have the <nettle/hmac.h> header file.
        .HAVE_NETTLE_HMAC_H = 1,

        // Define to 1 if you have the <nettle/md5.h> header file.
        .HAVE_NETTLE_MD5_H = null,

        // Define to 1 if you have the <nettle/pbkdf2.h> header file.
        .HAVE_NETTLE_PBKDF2_H = 1,

        // Define to 1 if you have the <nettle/ripemd160.h> header file.
        .HAVE_NETTLE_RIPEMD160_H = 1,

        // Define to 1 if you have the <nettle/sha.h> header file.
        .HAVE_NETTLE_SHA_H = 1,

        // Define to 1 if you have the `nl_langinfo' function.
        .HAVE_NL_LANGINFO = 1,

        // Define to 1 if you have the `openat' function.
        .HAVE_OPENAT = 1,

        // Define to 1 if you have the <paths.h> header file.
        .HAVE_PATHS_H = 1,

        // Define to 1 if you have the <pcreposix.h> header file.
        .HAVE_PCREPOSIX_H = 1,

        // Define to 1 if you have the `pipe' function.
        .HAVE_PIPE = 1,

        // Define to 1 if you have the `PKCS5_PBKDF2_HMAC_SHA1' function.
        .HAVE_PKCS5_PBKDF2_HMAC_SHA1 = 1,

        // Define to 1 if you have the `poll' function.
        .HAVE_POLL = 1,

        // Define to 1 if you have the <poll.h> header file.
        .HAVE_POLL_H = 1,

        // Define to 1 if you have the `posix_spawnp' function.
        .HAVE_POSIX_SPAWNP = 1,

        // Define to 1 if you have the <process.h> header file.
        .HAVE_PROCESS_H = 1,

        // Define to 1 if you have the <pthread.h> header file.
        .HAVE_PTHREAD_H = 1,

        // Define to 1 if you have the <pwd.h> header file.
        .HAVE_PWD_H = 1,

        // Define to 1 if you have the `readdir_r' function.
        .HAVE_READDIR_R = 1,

        // Define to 1 if you have the `readlink' function.
        .HAVE_READLINK = 1,

        // Define to 1 if you have the `readlinkat' function.
        .HAVE_READLINKAT = 1,

        // Define to 1 if you have the `readpassphrase' function.
        .HAVE_READPASSPHRASE = 1,

        // Define to 1 if you have the <readpassphrase.h> header file.
        .HAVE_READPASSPHRASE_H = 1,

        // Define to 1 if you have the <regex.h> header file.
        .HAVE_REGEX_H = 1,

        // Define to 1 if you have the `select' function.
        .HAVE_SELECT = 1,

        // Define to 1 if you have the `setenv' function.
        .HAVE_SETENV = 1,

        // Define to 1 if you have the `setlocale' function.
        .HAVE_SETLOCALE = 1,

        // Define to 1 if you have the `sigaction' function.
        .HAVE_SIGACTION = 1,

        // Define to 1 if you have the <signal.h> header file.
        .HAVE_SIGNAL_H = 1,

        // Define to 1 if you have the <spawn.h> header file.
        .HAVE_SPAWN_H = 1,

        // Define to 1 if you have the `statfs' function.
        .HAVE_STATFS = null,

        // Define to 1 if you have the `statvfs' function.
        .HAVE_STATVFS = 1,

        // Define to 1 if `stat' has the bug that it succeeds when given the
        //   zero-length file name argument.
        .HAVE_STAT_EMPTY_STRING_BUG = 1,

        // Define to 1 if you have the <stdarg.h> header file.
        .HAVE_STDARG_H = 1,

        // Define to 1 if you have the <stdint.h> header file.
        .HAVE_STDINT_H = 1,

        // Define to 1 if you have the <stdlib.h> header file.
        .HAVE_STDLIB_H = 1,

        // Define to 1 if you have the `strchr' function.
        .HAVE_STRCHR = 1,

        // Define to 1 if you have the `strnlen' function.
        .HAVE_STRNLEN = 1,

        // Define to 1 if you have the `strdup' function.
        .HAVE_STRDUP = 1,

        // Define to 1 if you have the `strerror' function.
        .HAVE_STRERROR = 1,

        // Define to 1 if you have the `strerror_r' function.
        .HAVE_STRERROR_R = 1,

        // Define to 1 if you have the `strftime' function.
        .HAVE_STRFTIME = 1,

        // Define to 1 if you have the <strings.h> header file.
        .HAVE_STRINGS_H = 1,

        // Define to 1 if you have the <string.h> header file.
        .HAVE_STRING_H = 1,

        // Define to 1 if you have the `strrchr' function.
        .HAVE_STRRCHR = 1,

        // Define to 1 if `f_namemax' is a member of `struct statfs'.
        .HAVE_STRUCT_STATFS_F_NAMEMAX = null,

        // Define to 1 if `f_iosize' is a member of `struct statvfs'.
        .HAVE_STRUCT_STATVFS_F_IOSIZE = null,

        // Define to 1 if `st_birthtime' is a member of `struct stat'.
        .HAVE_STRUCT_STAT_ST_BIRTHTIME = 1,

        // Define to 1 if `st_birthtimespec.tv_nsec' is a member of `struct stat'.
        .HAVE_STRUCT_STAT_ST_BIRTHTIMESPEC_TV_NSEC = 1,

        // Define to 1 if `st_blksize' is a member of `struct stat'.
        .HAVE_STRUCT_STAT_ST_BLKSIZE = 1,

        // Define to 1 if `st_flags' is a member of `struct stat'.
        .HAVE_STRUCT_STAT_ST_FLAGS = 1,

        // Define to 1 if `st_mtimespec.tv_nsec' is a member of `struct stat'.
        .HAVE_STRUCT_STAT_ST_MTIMESPEC_TV_NSEC = 1,

        // Define to 1 if `st_mtime_n' is a member of `struct stat'.
        .HAVE_STRUCT_STAT_ST_MTIME_N = 1,

        // Define to 1 if `st_mtime_usec' is a member of `struct stat'.
        .HAVE_STRUCT_STAT_ST_MTIME_USEC = 1,

        // Define to 1 if `st_mtim.tv_nsec' is a member of `struct stat'.
        .HAVE_STRUCT_STAT_ST_MTIM_TV_NSEC = 1,

        // Define to 1 if `st_umtime' is a member of `struct stat'.
        .HAVE_STRUCT_STAT_ST_UMTIME = 1,

        // Define to 1 if `tm_gmtoff' is a member of `struct tm'.
        .HAVE_STRUCT_TM_TM_GMTOFF = 1,

        // Define to 1 if `__tm_gmtoff' is a member of `struct tm'.
        .HAVE_STRUCT_TM___TM_GMTOFF = 1,

        // Define to 1 if you have `struct vfsconf'.
        .HAVE_STRUCT_VFSCONF = 1,

        // Define to 1 if you have `struct xvfsconf'.
        .HAVE_STRUCT_XVFSCONF = 1,

        // Define to 1 if you have the `symlink' function.
        .HAVE_SYMLINK = 1,

        // Define to 1 if you have the <sys/acl.h> header file.
        .HAVE_SYS_ACL_H = null,

        // Define to 1 if you have the <sys/cdefs.h> header file.
        .HAVE_SYS_CDEFS_H = 1,

        // Define to 1 if you have the <sys/dir.h> header file, and it defines `DIR'.
        .HAVE_SYS_DIR_H = 1,

        // Define to 1 if you have the <sys/ea.h> header file.
        .HAVE_SYS_EA_H = null,

        // Define to 1 if you have the <sys/extattr.h> header file.
        .HAVE_SYS_EXTATTR_H = null,

        // Define to 1 if you have the <sys/ioctl.h> header file.
        .HAVE_SYS_IOCTL_H = 1,

        // Define to 1 if you have the <sys/mkdev.h> header file.
        .HAVE_SYS_MKDEV_H = null,

        // Define to 1 if you have the <sys/mount.h> header file.
        .HAVE_SYS_MOUNT_H = 1,

        // Define to 1 if you have the <sys/ndir.h> header file, and it defines `DIR'.

        .HAVE_SYS_NDIR_H = 1,

        // Define to 1 if you have the <sys/param.h> header file.
        .HAVE_SYS_PARAM_H = 1,

        // Define to 1 if you have the <sys/poll.h> header file.
        .HAVE_SYS_POLL_H = 1,

        // Define to 1 if you have the <sys/richacl.h> header file.
        .HAVE_SYS_RICHACL_H = 1,

        // Define to 1 if you have the <sys/select.h> header file.
        .HAVE_SYS_SELECT_H = 1,

        // Define to 1 if you have the <sys/statfs.h> header file.
        .HAVE_SYS_STATFS_H = null,

        // Define to 1 if you have the <sys/statvfs.h> header file.
        .HAVE_SYS_STATVFS_H = 1,

        // Define to 1 if you have the <sys/stat.h> header file.
        .HAVE_SYS_STAT_H = 1,

        // Define to 1 if you have the <sys/sysmacros.h> header file.
        .HAVE_SYS_SYSMACROS_H = null,

        // Define to 1 if you have the <sys/time.h> header file.
        .HAVE_SYS_TIME_H = 1,

        // Define to 1 if you have the <sys/types.h> header file.
        .HAVE_SYS_TYPES_H = 1,

        // Define to 1 if you have the <sys/utime.h> header file.
        .HAVE_SYS_UTIME_H = null,

        // Define to 1 if you have the <sys/utsname.h> header file.
        .HAVE_SYS_UTSNAME_H = 1,

        // Define to 1 if you have the <sys/vfs.h> header file.
        .HAVE_SYS_VFS_H = 1,

        // Define to 1 if you have <sys/wait.h> that is POSIX.1 compatible.
        .HAVE_SYS_WAIT_H = 1,

        // Define to 1 if you have the <sys/xattr.h> header file.
        .HAVE_SYS_XATTR_H = null,

        // Define to 1 if you have the `timegm' function.
        .HAVE_TIMEGM = 1,

        // Define to 1 if you have the <time.h> header file.
        .HAVE_TIME_H = 1,

        // Define to 1 if you have the `tzset' function.
        .HAVE_TZSET = 1,

        // Define to 1 if you have the <unistd.h> header file.
        .HAVE_UNISTD_H = 1,

        // Define to 1 if you have the `unlinkat' function.
        .HAVE_UNLINKAT = 1,

        // Define to 1 if you have the `unsetenv' function.
        .HAVE_UNSETENV = 1,

        // Define to 1 if the system has the type `unsigned long long'.
        .HAVE_UNSIGNED_LONG_LONG = 1,

        // Define to 1 if the system has the type `unsigned long long int'.
        .HAVE_UNSIGNED_LONG_LONG_INT = 1,

        // Define to 1 if you have the `utime' function.
        .HAVE_UTIME = 1,

        // Define to 1 if you have the `utimensat' function.
        .HAVE_UTIMENSAT = 1,

        // Define to 1 if you have the `utimes' function.
        .HAVE_UTIMES = 1,

        // Define to 1 if you have the <utime.h> header file.
        .HAVE_UTIME_H = 1,

        // Define to 1 if you have the `vfork' function.
        .HAVE_VFORK = 1,

        // Define to 1 if you have the `vprintf' function.
        .HAVE_VPRINTF = 1,

        // Define to 1 if you have the <wchar.h> header file.
        .HAVE_WCHAR_H = 1,

        // Define to 1 if the system has the type `wchar_t'.
        .HAVE_WCHAR_T = 1,

        // Define to 1 if you have the `wcrtomb' function.
        .HAVE_WCRTOMB = 1,

        // Define to 1 if you have the `wcscmp' function.
        .HAVE_WCSCMP = 1,

        // Define to 1 if you have the `wcscpy' function.
        .HAVE_WCSCPY = 1,

        // Define to 1 if you have the `wcslen' function.
        .HAVE_WCSLEN = 1,

        // Define to 1 if you have the `wctomb' function.
        .HAVE_WCTOMB = 1,

        // Define to 1 if you have the <wctype.h> header file.
        .HAVE_WCTYPE_H = 1,

        // Define to 1 if you have the <wincrypt.h> header file.
        .HAVE_WINCRYPT_H = null,

        // Define to 1 if you have the <windows.h> header file.
        .HAVE_WINDOWS_H = null,

        // Define to 1 if you have the <winioctl.h> header file.
        .HAVE_WINIOCTL_H = 1,

        // Define to 1 if you have _CrtSetReportMode in <crtdbg.h>
        .HAVE__CrtSetReportMode = 1,

        // Define to 1 if you have the `wmemcmp' function.
        .HAVE_WMEMCMP = 1,

        // Define to 1 if you have the `wmemcpy' function.
        .HAVE_WMEMCPY = 1,

        // Define to 1 if you have the `wmemmove' function.
        .HAVE_WMEMMOVE = 1,

        // Define to 1 if you have a working EXT2_IOC_GETFLAGS
        .HAVE_WORKING_EXT2_IOC_GETFLAGS = 1,

        // Define to 1 if you have a working FS_IOC_GETFLAGS
        .HAVE_WORKING_FS_IOC_GETFLAGS = 1,

        // Define to 1 if you have the <zlib.h> header file.
        .HAVE_ZLIB_H = 1,

        // Define to 1 if you have the <zstd.h> header file.
        .HAVE_ZSTD_H = null,

        // Define to 1 if you have the `ctime_s' function.
        .HAVE_CTIME_S = null,

        // Define to 1 if you have the `_fseeki64' function.
        .HAVE__FSEEKI64 = null,

        // Define to 1 if you have the `_get_timezone' function.
        .HAVE__GET_TIMEZONE = 1,

        // Define to 1 if you have the `gmtime_s' function.
        .HAVE_GMTIME_S = null,

        // Define to 1 if you have the `localtime_s' function.
        .HAVE_LOCALTIME_S = null,

        // Define to 1 if you have the `_mkgmtime' function.
        .HAVE__MKGMTIME = null,

        // Define as const if the declaration of iconv() needs const.
        //#define ICONV_CONST @ICONV_CONST@

        // Version number of libarchive as a single integer
        .LIBARCHIVE_VERSION_NUMBER = "@LIBARCHIVE_VERSION_NUMBER@",

        // Version number of libarchive
        .LIBARCHIVE_VERSION_STRING = "@LIBARCHIVE_VERSION_STRING@",

        // Define to 1 if `lstat' dereferences a symlink specified with a trailing slash.
        .LSTAT_FOLLOWS_SLASHED_SYMLINK = 1,

        // Define to 1 if `major', `minor', and `makedev' are declared in <mkdev.h>.
        .MAJOR_IN_MKDEV = null,

        // Define to 1 if `major', `minor', and `makedev' are declared in <sysmacros.h>.
        .MAJOR_IN_SYSMACROS = null,

        // Define to 1 if your C compiler doesn't accept -c and -o together.
        .NO_MINUS_C_MINUS_O = 1,

        // The size of `wchar_t', as computed by sizeof.
        .SIZEOF_WCHAR_T = 2, //@SIZEOF_WCHAR_T@,

        // Define to 1 if strerror_r returns char *.
        .STRERROR_R_CHAR_P = 1,

        // Define to 1 if you can safely include both <sys/time.h> and <time.h>.
        .TIME_WITH_SYS_TIME = 1,

        .@"const" = .@"const",
        .gid_t = .gid_t,
        .id_t = .id_t,
        .mode_t = .mode_t,
        .off_t = .off_t,
        .pid_t = .pid_t,
        .size_t = .size_t,
        .ssize_t = .ssize_t,
        .uid_t = .uid_t,
        .uintptr_t = .uintptr_t,
        .intptr_t = .intptr_t,
    });
    libarchive.addConfigHeader(config_header);
}

const libarchive_srcs = &.{
    "libarchive/archive_acl.c",
    "libarchive/archive_blake2s_ref.c",
    "libarchive/archive_blake2sp_ref.c",
    "libarchive/archive_check_magic.c",
    "libarchive/archive_cmdline.c",
    "libarchive/archive_cryptor.c",
    "libarchive/archive_digest.c",
    "libarchive/archive_disk_acl_darwin.c",
    "libarchive/archive_disk_acl_freebsd.c",
    "libarchive/archive_disk_acl_linux.c",
    "libarchive/archive_disk_acl_sunos.c",
    "libarchive/archive_entry.c",
    "libarchive/archive_entry_copy_bhfi.c",
    "libarchive/archive_entry_copy_stat.c",
    "libarchive/archive_entry_link_resolver.c",
    "libarchive/archive_entry_sparse.c",
    "libarchive/archive_entry_stat.c",
    "libarchive/archive_entry_strmode.c",
    "libarchive/archive_entry_xattr.c",
    "libarchive/archive_getdate.c",
    "libarchive/archive_hmac.c",
    "libarchive/archive_match.c",
    "libarchive/archive_options.c",
    "libarchive/archive_pack_dev.c",
    "libarchive/archive_pathmatch.c",
    "libarchive/archive_ppmd7.c",
    "libarchive/archive_ppmd8.c",
    "libarchive/archive_random.c",
    "libarchive/archive_rb.c",
    "libarchive/archive_read.c",
    "libarchive/archive_read_add_passphrase.c",
    "libarchive/archive_read_append_filter.c",
    "libarchive/archive_read_data_into_fd.c",
    "libarchive/archive_read_disk_entry_from_file.c",
    "libarchive/archive_read_disk_posix.c",
    "libarchive/archive_read_disk_set_standard_lookup.c",
    "libarchive/archive_read_disk_windows.c",
    "libarchive/archive_read_extract.c",
    "libarchive/archive_read_extract2.c",
    "libarchive/archive_read_open_fd.c",
    "libarchive/archive_read_open_file.c",
    "libarchive/archive_read_open_filename.c",
    "libarchive/archive_read_open_memory.c",
    "libarchive/archive_read_set_format.c",
    "libarchive/archive_read_set_options.c",
    "libarchive/archive_read_support_filter_all.c",
    "libarchive/archive_read_support_filter_by_code.c",
    "libarchive/archive_read_support_filter_bzip2.c",
    "libarchive/archive_read_support_filter_compress.c",
    "libarchive/archive_read_support_filter_grzip.c",
    "libarchive/archive_read_support_filter_gzip.c",
    "libarchive/archive_read_support_filter_lrzip.c",
    "libarchive/archive_read_support_filter_lz4.c",
    "libarchive/archive_read_support_filter_lzop.c",
    "libarchive/archive_read_support_filter_none.c",
    "libarchive/archive_read_support_filter_program.c",
    "libarchive/archive_read_support_filter_rpm.c",
    "libarchive/archive_read_support_filter_uu.c",
    "libarchive/archive_read_support_filter_xz.c",
    "libarchive/archive_read_support_filter_zstd.c",
    "libarchive/archive_read_support_format_7zip.c",
    "libarchive/archive_read_support_format_all.c",
    "libarchive/archive_read_support_format_ar.c",
    "libarchive/archive_read_support_format_by_code.c",
    "libarchive/archive_read_support_format_cab.c",
    "libarchive/archive_read_support_format_cpio.c",
    "libarchive/archive_read_support_format_empty.c",
    "libarchive/archive_read_support_format_iso9660.c",
    "libarchive/archive_read_support_format_lha.c",
    "libarchive/archive_read_support_format_mtree.c",
    "libarchive/archive_read_support_format_rar.c",
    "libarchive/archive_read_support_format_rar5.c",
    "libarchive/archive_read_support_format_raw.c",
    "libarchive/archive_read_support_format_tar.c",
    "libarchive/archive_read_support_format_warc.c",
    "libarchive/archive_read_support_format_xar.c",
    "libarchive/archive_read_support_format_zip.c",
    "libarchive/archive_string.c",
    "libarchive/archive_string_sprintf.c",
    "libarchive/archive_util.c",
    "libarchive/archive_version_details.c",
    "libarchive/archive_virtual.c",
    "libarchive/archive_windows.c",
    "libarchive/archive_write.c",
    "libarchive/archive_write_add_filter.c",
    "libarchive/archive_write_add_filter_b64encode.c",
    "libarchive/archive_write_add_filter_by_name.c",
    "libarchive/archive_write_add_filter_bzip2.c",
    "libarchive/archive_write_add_filter_compress.c",
    "libarchive/archive_write_add_filter_grzip.c",
    "libarchive/archive_write_add_filter_gzip.c",
    "libarchive/archive_write_add_filter_lrzip.c",
    "libarchive/archive_write_add_filter_lz4.c",
    "libarchive/archive_write_add_filter_lzop.c",
    "libarchive/archive_write_add_filter_none.c",
    "libarchive/archive_write_add_filter_program.c",
    "libarchive/archive_write_add_filter_uuencode.c",
    "libarchive/archive_write_add_filter_xz.c",
    "libarchive/archive_write_add_filter_zstd.c",
    "libarchive/archive_write_disk_posix.c",
    "libarchive/archive_write_disk_set_standard_lookup.c",
    "libarchive/archive_write_disk_windows.c",
    "libarchive/archive_write_open_fd.c",
    "libarchive/archive_write_open_file.c",
    "libarchive/archive_write_open_filename.c",
    "libarchive/archive_write_open_memory.c",
    "libarchive/archive_write_set_format.c",
    "libarchive/archive_write_set_format_7zip.c",
    "libarchive/archive_write_set_format_ar.c",
    "libarchive/archive_write_set_format_by_name.c",
    "libarchive/archive_write_set_format_cpio.c",
    "libarchive/archive_write_set_format_cpio_binary.c",
    "libarchive/archive_write_set_format_cpio_newc.c",
    "libarchive/archive_write_set_format_cpio_odc.c",
    "libarchive/archive_write_set_format_filter_by_ext.c",
    "libarchive/archive_write_set_format_gnutar.c",
    "libarchive/archive_write_set_format_iso9660.c",
    "libarchive/archive_write_set_format_mtree.c",
    "libarchive/archive_write_set_format_pax.c",
    "libarchive/archive_write_set_format_raw.c",
    "libarchive/archive_write_set_format_shar.c",
    "libarchive/archive_write_set_format_ustar.c",
    "libarchive/archive_write_set_format_v7tar.c",
    "libarchive/archive_write_set_format_warc.c",
    "libarchive/archive_write_set_format_xar.c",
    "libarchive/archive_write_set_format_zip.c",
    "libarchive/archive_write_set_options.c",
    "libarchive/archive_write_set_passphrase.c",
    "libarchive/filter_fork_posix.c",
    "libarchive/filter_fork_windows.c",
    "libarchive/xxhash.c",
};
