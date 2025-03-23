#
# Completions for the gpg2 command.
#
# This program accepts an rather large number of switches. It allows
# you to do things like changing what file descriptor errors should be
# written to, to make gpg2 use a different locale than the one
# specified in the environment or to specify an alternative home
# directory.

# Switches related to debugging, switches whose use is not
# recommended, switches whose behaviour is as of yet undefined,
# switches for experimental features, switches to make gpg2 compliant
# to legacy pgp-versions, dos-specific switches, switches meant for
# the options file and deprecated or obsolete switches have all been
# removed. The remaining list of completions is still quite
# impressive.

#
# Various functions used for dynamic completions
#

function __fish_complete_gpg2_user_id -d "Complete using gpg2 user ids"
	# gpg2 doesn't seem to like it when you use the whole key name as a
	# completion, so we skip the <EMAIL> part and use it a s a
	# description.
	# It also replaces colons with \x3a
	gpg2 --list-keys --with-colon|cut -d : -f 10 | sed -ne 's/\\\x3a/:/g' -e 's/\(.*\) <\(.*\)>/\1'\t'\2/p'
end

function __fish_complete_gpg2_key_id -d 'Complete using gpg2 key ids'
	# Use user_id as the description
	set -l lastid
	gpg2 --list-keys --with-colons | while read garbage
		switch $garbage
			case "uid*"
				echo $garbage | cut -d ":" -f 10 | sed -e "s/\\\x3a/:/g" | read lastid
			case "*"
				echo $garbage | cut -d ":" -f 5 | read fingerprint
		end
		printf "%s\t%s\n" $fingerprint $lastid
	end
end

function __fish_print_gpg2_algo -d "Complete using all algorithms of the type specified in argv[1] supported by gpg2. argv[1] is a regexp"
	# Set a known locale, so that the output format of 'gpg2 --version'
	# is at least somewhat predictable. The locale will automatically
	# expire when the function goes out of scope, and the original locale
	# will take effect again.
	set -lx LC_ALL C

	# XXX this misses certain ciphers in gpg2 --version - redo this entirely and use fish's annoying  group printing as a feature finally!
	gpg2 --version | __fish_sgrep "$argv:"| __fish_sgrep -v "Home:"|cut -d : -f 2 |tr , \n|tr -d " "
end


#
# gpg2 subcommands
#

complete -c gpg2 -s s -l sign --description "Make a signature"
complete -c gpg2 -l clearsign --description "Make a clear text signature"
complete -c gpg2 -s b -l detach-sign --description "Make a detached signature"
complete -c gpg2 -s e -l encrypt --description "Encrypt data"
complete -c gpg2 -s c -l symmetric --description "Encrypt with a symmetric cipher using a passphrase"
complete -c gpg2 -l store --description "Store only (make a simple RFC1991 packet)"
complete -c gpg2 -l decrypt --description "Decrypt specified file or stdin"
complete -c gpg2 -l verify --description "Assume specified file or stdin is sigfile and verify it"
complete -c gpg2 -l multifile --description "Modify certain other commands to accept multiple files for processing"
complete -c gpg2 -l verify-files --description "Identical to '--multifile --verify'"
complete -c gpg2 -l encrypt-files --description "Identical to '--multifile --encrypt'"
complete -c gpg2 -l decrypt-files --description "Identical to --multifile --decrypt"

complete -c gpg2 -s k -l list-keys -xa "(__fish_complete_gpg2_user_id)" --description "List all keys from the public keyrings, or just the ones given on the command line"
complete -c gpg2 -l list-public-keys -xa "(__fish_complete_gpg2_user_id)" --description "List all keys from the public keyrings, or just the ones given on the command line"
complete -c gpg2 -s K -l list-secret-keys -xa "(__fish_complete_gpg2_user_id)" --description "List all keys from the secret keyrings, or just the ones given on the command line"
complete -c gpg2 -l list-sigs -xa "(__fish_complete_gpg2_user_id)" --description "Same as --list-keys, but the signatures are listed too"

complete -c gpg2 -l check-sigs -xa "(__fish_complete_gpg2_user_id)" --description "Same as --list-keys, but the signatures are listed and verified"
complete -c gpg2 -l fingerprint -xa "(__fish_complete_gpg2_user_id)" --description "List all keys with their fingerprints"
complete -c gpg2 -l gen-key --description "Generate a new key pair"

complete -c gpg2 -l edit-key --description "Present a menu which enables you to do all key related tasks" -xa "(__fish_complete_gpg2_user_id)"

complete -c gpg2 -l sign-key -xa "(__fish_complete_gpg2_user_id)" --description "Sign a public key with your secret key"
complete -c gpg2 -l lsign-key -xa "(__fish_complete_gpg2_user_id)" --description "Sign a public key with your secret key but mark it as non exportable"

complete -c gpg2 -l delete-key -xa "(__fish_complete_gpg2_user_id)" --description "Remove key from the public keyring"
complete -c gpg2 -l delete-secret-key -xa "(__fish_complete_gpg2_user_id)" --description "Remove key from the secret and public keyring"
complete -c gpg2 -l delete-secret-and-public-key -xa "(__fish_complete_gpg2_user_id)" --description "Same as --delete-key, but if a secret key exists, it will be removed first"

complete -c gpg2 -l gen-revoke -xa "(__fish_complete_gpg2_user_id)" --description "Generate a revocation certificate for the complete key"
complete -c gpg2 -l desig-revoke -xa "(__fish_complete_gpg2_user_id)" --description "Generate a designated revocation certificate for a key"

complete -c gpg2 -l export -xa "(__fish_complete_gpg2_user_id)" --description 'Export all or the given keys from all keyrings'
complete -c gpg2 -l send-keys -xa "(__fish_complete_gpg2_key_id)" --description "Same as --export but sends the keys to a keyserver"
complete -c gpg2 -l export-secret-keys -xa "(__fish_complete_gpg2_user_id)" --description "Same as --export, but exports the secret keys instead"
complete -c gpg2 -l export-secret-subkeys -xa "(__fish_complete_gpg2_user_id)" --description "Same as --export, but exports the secret keys instead"

complete -c gpg2 -l import --description 'Import/merge keys'
complete -c gpg2 -l fast-import --description 'Import/merge keys'

complete -c gpg2 -l recv-keys -xa "(__fish_complete_gpg2_key_id)" --description "Import the keys with the given key IDs from a keyserver"
complete -c gpg2 -l refresh-keys -xa "(__fish_complete_gpg2_key_id)" --description "Request updates from a keyserver for keys that already exist on the local keyring"
complete -c gpg2 -l search-keys -xa "(__fish_complete_gpg2_user_id)" --description "Search the keyserver for the given names"
complete -c gpg2 -l update-trustdb --description "Do trust database maintenance"
complete -c gpg2 -l check-trustdb --description "Do trust database maintenance without user interaction"

complete -c gpg2 -l export-ownertrust --description "Send the ownertrust values to stdout"
complete -c gpg2 -l import-ownertrust --description "Update the trustdb with the ownertrust values stored in specified files or stdin"

complete -c gpg2 -l rebuild-keydb-caches --description "Create signature caches in the keyring"

complete -c gpg2 -l print-md -xa "(__fish_print_gpg2_algo Hash)" --description "Print message digest of specified algorithm for all given files or stdin"
complete -c gpg2 -l print-mds --description "Print message digest of all algorithms for all given files or stdin"

complete -c gpg2 -l gen-random -xa "0 1 2" --description "Emit specified number of random bytes of the given quality level"

complete -c gpg2 -l version --description "Display version and supported algorithms, and exit"
complete -c gpg2 -l warranty --description "Display warranty and exit"
complete -c gpg2 -s h -l help --description "Display help and exit"


#
# gpg2 options
#

complete -c gpg2 -s a -l armor --description "Create ASCII armored output"
complete -c gpg2 -s o -l output -r --description "Write output to specified file"

complete -c gpg2 -l max-output --description "Sets a limit on the number of bytes that will be generated when processing a file" -x

complete -c gpg2 -s u -l local-user -xa "(__fish_complete_gpg2_user_id)" --description "Use specified key as the key to sign with"
complete -c gpg2 -l default-key -xa "(__fish_complete_gpg2_user_id)" --description "Use specified key as the default key to sign with"

complete -c gpg2 -s r -l recipient -xa "(__fish_complete_gpg2_user_id)" --description "Encrypt for specified user id"
complete -c gpg2 -s R -l hidden-recipient -xa "(__fish_complete_gpg2_user_id)" --description "Encrypt for specified user id, but hide the keyid of the key"
complete -c gpg2 -l default-recipient -xa "(__fish_complete_gpg2_user_id)" --description "Use specified user id as default recipient"
complete -c gpg2 -l default-recipient-self --description "Use the default key as default recipient"
complete -c gpg2 -l no-default-recipient --description "Reset --default-recipient and --default-recipient-self"

complete -c gpg2 -s v -l verbose --description "Give more information during processing"
complete -c gpg2 -s q -l quiet --description "Quiet mode"

complete -c gpg2 -s z --description "Compression level" -xa "(seq 1 9)"
complete -c gpg2 -l compress-level --description "Compression level" -xa "(seq 1 9)"
complete -c gpg2 -l bzip2-compress-level --description "Compression level" -xa "(seq 1 9)"
complete -c gpg2 -l bzip2-decompress-lowmem --description "Use a different decompression method for BZIP2 compressed files"

complete -c gpg2 -s t -l textmode --description "Treat input files as text and store them in the OpenPGP canonical text form with standard 'CRLF' line endings"
complete -c gpg2 -l no-textmode --description "Don't treat input files as text and store them in the OpenPGP canonical text form with standard 'CRLF' line endings"

complete -c gpg2 -s n -l dry-run --description "Don't make any changes (this is not completely implemented)"

complete -c gpg2 -s i -l interactive --description "Prompt before overwrite"

complete -c gpg2 -l batch --description "Batch mode"
complete -c gpg2 -l no-batch --description "Don't use batch mode"
complete -c gpg2 -l no-tty --description "Never write output to terminal"

complete -c gpg2 -l yes --description "Assume yes on most questions"
complete -c gpg2 -l no --description "Assume no on most questions"

complete -c gpg2 -l ask-cert-level --description "Prompt for a certification level when making a key signature"
complete -c gpg2 -l no-ask-cert-level --description "Don't prompt for a certification level when making a key signature"
complete -c gpg2 -l default-cert-level -xa "0\t'Not verified' 1\t'Not verified' 2\t'Caual verification' 3\t'Extensive verification'" --description "The default certification level to use for the level check when signing a key"
complete -c gpg2 -l min-cert-level -xa "0 1 2 3" --description "Disregard any signatures with a certification level below specified level when building the trust database"

complete -c gpg2 -l trusted-key -xa "(__fish_complete_gpg2_key_id)" --description "Assume that the specified key is as trustworthy as one of your own secret keys"
complete -c gpg2 -l trust-model -xa "pgp classic direct always" --description "Specify trust model"

complete -c gpg2 -l keyid-format -xa "short 0xshort long 0xlong" --description "Select how to display key IDs"

complete -c gpg2 -l keyserver -x --description "Use specified keyserver"
complete -c gpg2 -l keyserver-options -xa "(__fish_append , include-revoked include-disabled honor-keyserver-url include-subkeys use-temp-files keep-temp-files verbose timeout http-proxy auto-key-retrieve)" --description "Options for the keyserver"

complete -c gpg2 -l import-options -xa "(__fish_append , import-local-sigs repair-pks-subkey-bug merge-only)" --description "Options for importing keys"
complete -c gpg2 -l export-options -xa "(__fish_append , export-local-sigs export-attributes export-sensitive-revkeys export-minimal)" --description "Options for exporting keys"
complete -c gpg2 -l list-options -xa "(__fish_append , show-photos show-policy-urls show-notations show-std-notations show-user-notations show-keyserver-urls show-uid-validity show-unusable-uids show-unusable-subkeys show-keyring show-sig-expire show-sig-subpackets )" --description "Options for listing keys and signatures"
complete -c gpg2 -l verify-options -xa "(__fish_append , show-photos show-policy-urls show-notations show-std-notations show-user-notations show-keyserver-urls show-uid-validity show-unusable-uids)" --description "Options for verifying signatures"

complete -c gpg2 -l photo-viewer -r --description "The command line that should be run to view a photo ID"
complete -c gpg2 -l exec-path -r --description "Sets a list of directories to search for photo viewers and keyserver helpers"

complete -c gpg2 -l show-keyring --description "Display the keyring name at the head of key listings to show which keyring a given key resides on"
complete -c gpg2 -l keyring -r --description "Add specified file to the current list of keyrings"

complete -c gpg2 -l secret-keyring -r --description "Add specified file to the current list of secret keyrings"
complete -c gpg2 -l primary-keyring -r --description "Designate specified file as the primary public keyring"

complete -c gpg2 -l trustdb-name -r --description "Use specified file instead of the default trustdb"
complete -c gpg2 -l homedir -xa "(__fish_complete_directories (commandline -ct))" --description "Set the home directory"
complete -c gpg2 -l display-charset -xa " iso-8859-1 iso-8859-2 iso-8859-15 koi8-r utf-8 " --description "Set the native character set"

complete -c gpg2 -l utf8-strings --description "Assume that following command line arguments are given in UTF8"
complete -c gpg2 -l no-utf8-strings --description "Assume that following arguments are encoded in the character set specified by --display-charset"
complete -c gpg2 -l options -r --description "Read options from specified file, do not read the default options file"
complete -c gpg2 -l no-options --description "Shortcut for '--options /dev/null'"
complete -c gpg2 -l load-extension -x --description "Load an extension module"

complete -c gpg2 -l status-fd -x --description "Write special status strings to the specified file descriptor"
complete -c gpg2 -l logger-fd -x --description "Write log output to the specified file descriptor"
complete -c gpg2 -l attribute-fd --description "Write attribute subpackets to the specified file descriptor"

complete -c gpg2 -l sk-comments --description "Include secret key comment packets when exporting secret keys"
complete -c gpg2 -l no-sk-comments --description "Don't include secret key comment packets when exporting secret keys"

complete -c gpg2 -l comment -x --description "Use specified string as comment string"
complete -c gpg2 -l no-comments --description "Don't use a comment string"

complete -c gpg2 -l emit-version --description "Include the version string in ASCII armored output"
complete -c gpg2 -l no-emit-version --description "Don't include the version string in ASCII armored output"

complete -c gpg2 -l sig-notation -x
complete -c gpg2 -l cert-notation -x

complete -c gpg2 -s N -l set-notation -x --description "Put the specified name value pair into the signature as notation data"
complete -c gpg2 -l sig-policy-url -x --description "Set signature policy"
complete -c gpg2 -l cert-policy-url -x --description "Set certificate policy"
complete -c gpg2 -l set-policy-url -x --description "Set signature and certificate policy"
complete -c gpg2 -l sig-keyserver-url -x --description "Use specified URL as a preferred keyserver for data signatures"

complete -c gpg2 -l set-filename -x --description "Use specified string as the filename which is stored inside messages"

complete -c gpg2 -l for-your-eyes-only --description "Set the 'for your eyes only' flag in the message"
complete -c gpg2 -l no-for-your-eyes-only --description "Clear the 'for your eyes only' flag in the message"

complete -c gpg2 -l use-embedded-filename --description "Create file with name as given in data"
complete -c gpg2 -l no-use-embedded-filename --description "Don't create file with name as given in data"

complete -c gpg2 -l completes-needed -x --description "Number of completely trusted users to introduce a new key signer (defaults to 1)"
complete -c gpg2 -l marginals-needed -x --description "Number of marginally trusted users to introduce a new key signer (defaults to 3)"

complete -c gpg2 -l max-cert-depth -x --description "Maximum depth of a certification chain (default is 5)"

complete -c gpg2 -l cipher-algo -xa "(__fish_print_gpg2_algo Cipher)" --description "Use specified cipher algorithm"
complete -c gpg2 -l digest-algo -xa "(__fish_print_gpg2_algo Hash)" --description "Use specified message digest algorithm"
complete -c gpg2 -l compress-algo -xa "(__fish_print_gpg2_algo Compression)" --description "Use specified compression algorithm"
complete -c gpg2 -l cert-digest-algo -xa "(__fish_print_gpg2_algo Hash)" --description "Use specified message digest algorithm when signing a key"
complete -c gpg2 -l s2k-cipher-algo -xa "(__fish_print_gpg2_algo Cipher)" --description "Use specified cipher algorithm to protect secret keys"
complete -c gpg2 -l s2k-digest-algo -xa "(__fish_print_gpg2_algo Hash)" --description "Use specified digest algorithm to mangle the passphrases"
complete -c gpg2 -l s2k-mode -xa "0\t'Plain passphrase' 1\t'Salted passphrase' 3\t'Repeated salted mangling'" --description "Selects how passphrases are mangled"

complete -c gpg2 -l simple-sk-checksum --description 'Integrity protect secret keys by using a SHA-1 checksum'

complete -c gpg2 -l disable-cipher-algo -xa "(__fish_print_gpg2_algo Cipher)" --description "Never allow the use of specified cipher algorithm"
complete -c gpg2 -l disable-pubkey-algo -xa "(__fish_print_gpg2_algo Pubkey)" --description "Never allow the use of specified public key algorithm"

complete -c gpg2 -l no-sig-cache --description "Do not cache the verification status of key signatures"
complete -c gpg2 -l no-sig-create-check --description "Do not verify each signature right after creation"

complete -c gpg2 -l auto-check-trustdb --description "Automatically run the --check-trustdb command internally when needed"
complete -c gpg2 -l no-auto-check-trustdb --description "Never automatically run the --check-trustdb"

complete -c gpg2 -l throw-keyids --description "Do not put the recipient keyid into encrypted packets"
complete -c gpg2 -l no-throw-keyids --description "Put the recipient keyid into encrypted packets"
complete -c gpg2 -l not-dash-escaped --description "Change the behavior of cleartext signatures so that they can be used for patch files"

complete -c gpg2 -l escape-from-lines --description "Mangle From-field of email headers (default)"
complete -c gpg2 -l no-escape-from-lines --description "Do not mangle From-field of email headers"

complete -c gpg2 -l passphrase-fd -x --description "Read passphrase from specified file descriptor"
complete -c gpg2 -l command-fd -x --description "Read user input from specified file descriptor"

complete -c gpg2 -l use-agent --description "Try to use the GnuPG-Agent"
complete -c gpg2 -l no-use-agent --description "Do not try to use the GnuPG-Agent"
complete -c gpg2 -l gpg2-agent-info -x --description "Override value of gpg2_AGENT_INFO environment variable"

complete -c gpg2 -l force-v3-sigs --description "Force v3 signatures for signatures on data"
complete -c gpg2 -l no-force-v3-sigs --description "Do not force v3 signatures for signatures on data"

complete -c gpg2 -l force-v4-certs --description "Always use v4 key signatures even on v3 keys"
complete -c gpg2 -l no-force-v4-certs --description "Don't use v4 key signatures on v3 keys"

complete -c gpg2 -l force-mdc --description "Force the use of encryption with a modification detection code"
complete -c gpg2 -l disable-mdc --description "Disable the use of the modification detection code"

complete -c gpg2 -l allow-non-selfsigned-uid --description "Allow the import and use of keys with user IDs which are not self-signed"
complete -c gpg2 -l no-allow-non-selfsigned-uid --description "Do not allow the import and use of keys with user IDs which are not self-signed"

complete -c gpg2 -l allow-freeform-uid --description "Disable all checks on the form of the user ID while generating a new one"

complete -c gpg2 -l ignore-time-conflict --description "Do not fail if signature is older than key"
complete -c gpg2 -l ignore-valid-from --description "Allow subkeys that have a timestamp from the future"
complete -c gpg2 -l ignore-crc-error --description "Ignore CRC errors"
complete -c gpg2 -l ignore-mdc-error --description "Do not fail on MDC integrity protection failure"

complete -c gpg2 -l lock-once --description "Lock the databases the first time a lock is requested and do not release the lock until the process terminates"
complete -c gpg2 -l lock-multiple --description "Release the locks every time a lock is no longer needed"

complete -c gpg2 -l no-random-seed-file --description "Do not create an internal pool file for quicker generation of random numbers"
complete -c gpg2 -l no-verbose --description "Reset verbose level to 0"
complete -c gpg2 -l no-greeting --description "Suppress the initial copyright message"
complete -c gpg2 -l no-secmem-warning --description "Suppress the warning about 'using insecure memory'"
complete -c gpg2 -l no-permission-warning --description "Suppress the warning about unsafe file and home directory (--homedir) permissions"
complete -c gpg2 -l no-mdc-warning --description "Suppress the warning about missing MDC integrity protection"

complete -c gpg2 -l require-secmem --description "Refuse to run if GnuPG cannot get secure memory"

complete -c gpg2 -l no-require-secmem --description "Do not refuse to run if GnuPG cannot get secure memory (default)"
complete -c gpg2 -l no-armor --description "Assume the input data is not in ASCII armored format"

complete -c gpg2 -l no-default-keyring --description "Do not add the default keyrings to the list of keyrings"

complete -c gpg2 -l skip-verify --description "Skip the signature verification step"

complete -c gpg2 -l with-colons --description "Print key listings delimited by colons"
complete -c gpg2 -l with-key-data --description "Print key listings delimited by colons (like --with-colons) and print the public key data"
complete -c gpg2 -l with-fingerprint --description "Same as the command --fingerprint but changes only the format of the output and may be used together with another command"

complete -c gpg2 -l fast-list-mode --description "Changes the output of the list commands to work faster"
complete -c gpg2 -l fixed-list-mode --description "Do not merge primary user ID and primary key in --with-colon listing mode and print all timestamps as UNIX timestamps"

complete -c gpg2 -l list-only --description "Changes the behaviour of some commands. This is like --dry-run but different"

complete -c gpg2 -l show-session-key --description "Display the session key used for one message"
complete -c gpg2 -l override-session-key -x --description "Don't use the public key but the specified session key"

complete -c gpg2 -l ask-sig-expire --description "Prompt for an expiration time"
complete -c gpg2 -l no-ask-sig-expire --description "Do not prompt for an expiration time"

complete -c gpg2 -l ask-cert-expire --description "Prompt for an expiration time"
complete -c gpg2 -l no-ask-cert-expire --description "Do not prompt for an expiration time"

complete -c gpg2 -l try-all-secrets --description "Don't look at the key ID as stored in the message but try all secret keys in turn to find the right decryption key"
complete -c gpg2 -l enable-special-filenames --description "Enable a mode in which filenames of the form -&n, where n is a non-negative decimal number, refer to the file descriptor n and not to a file with that name"

complete -c gpg2 -l group -x --description "Sets up a named group, which is similar to aliases in email programs"
complete -c gpg2 -l ungroup --description "Remove a given entry from the --group list"
complete -c gpg2 -l no-groups --description "Remove all entries from the --group list"

complete -c gpg2 -l preserve-permissions --description "Don't change the permissions of a secret keyring back to user read/write only"

complete -c gpg2 -l personal-cipher-preferences -x --description "Set the list of personal cipher preferences to the specified string"
complete -c gpg2 -l personal-digest-preferences -x --description "Set the list of personal digest preferences to the specified string"
complete -c gpg2 -l personal-compress-preferences -x --description "Set the list of personal compression preferences to the specified string"
complete -c gpg2 -l default-preference-list -x --description "Set the list of default preferences to the specified string"
