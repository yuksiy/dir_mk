#!/bin/sh

# ==============================================================================
#   機能
#     ディレクトリリストに記載されたディレクトリを作成する
#   構文
#     USAGE 参照
#
#   Copyright (c) 2006-2017 Yukio Shiiya
#
#   This software is released under the MIT License.
#   https://opensource.org/licenses/MIT
# ==============================================================================

######################################################################
# 関数定義
######################################################################
PRE_PROCESS() {
	:
}

POST_PROCESS() {
	:
}

USAGE() {
	cat <<- EOF 1>&2
		Usage:
		    dir_mk.sh [OPTIONS ...] DIR_LIST
		
		    DIR_LIST : Specify a directory list.
		
		OPTIONS:
		    --help
		       Display this help and exit.
	EOF
}

CMD_V() {
	(eval "set -x; $*")
}

######################################################################
# 変数定義
######################################################################
LS_OPTIONS="-ald"

######################################################################
# メインルーチン
######################################################################

# オプションのチェック
CMD_ARG="`getopt -o \"\" -l help -- \"$@\" 2>&1`"
if [ $? -ne 0 ];then
	echo "-E ${CMD_ARG}" 1>&2
	USAGE;exit 1
fi
eval set -- "${CMD_ARG}"
while true ; do
	opt="$1"
	case "${opt}" in
	--help)
		USAGE;exit 0
		;;
	--)
		shift 1;break
		;;
	esac
done

# 第1引数のチェック
if [ "$1" = "" ];then
	echo "-E Missing DIR_LIST argument" 1>&2
	USAGE;exit 1
else
	DIR_LIST="$1"
	# ディレクトリリストのチェック
	if [ ! -f "${DIR_LIST}" ];then
		echo "-E DIR_LIST not a file -- \"${DIR_LIST}\"" 1>&2
		USAGE;exit 1
	fi
fi

# 作業開始前処理
PRE_PROCESS

#####################
# メインループ 開始 #
#####################

while read line ; do
	echo "${line}" | grep -q -e '^#' -e '^$'
	if [ $? -ne 0 ];then
		dir="`echo \"${line}\" | awk '{print $1}'`"
		if [ "${dir}" = "" ];then
			echo "-E Invalid DIR_LIST format -- \"${DIR_LIST}\"" 1>&2
			echo "${line}"
			POST_PROCESS;exit 1
		fi

		# 既存ディレクトリの場合
		if [ \( -d "${dir}" \) -a \( ! -h "${dir}" \) ];then
			echo "-W \"${dir}\" directory exist, skipped" 1>&2
		# 既存ディレクトリでない場合
		else
			# ディレクトリの作成
			CMD_V "mkdir \"${dir}\""
			if [ $? -ne 0 ];then
				echo "-E Command has ended unsuccessfully." 1>&2
				POST_PROCESS;exit 1
			fi
			# ディレクトリのLL
			eval "ls ${LS_OPTIONS} \"${dir}\""
			if [ $? -ne 0 ];then
				echo "-E Command has ended unsuccessfully." 1>&2
				POST_PROCESS;exit 1
			fi
		fi
	fi
done < "${DIR_LIST}"

#####################
# メインループ 終了 #
#####################

# 作業終了後処理
POST_PROCESS;exit 0

