<?php

// unset all headers, set content type header, exit with content
function exit_set_contents($content, $content_type = 'text/plain') {
	header_remove();
	header('Content-Type: '.$content_type.'; charset=utf-8');

	exit($content);
}

// return content as bash statement
function echo_bash($content = "") {
	return 'echo -e "'.$content.'"'.PHP_EOL;
}

// return JSON installer as bash file
function json_get_contents($name) {
	$data = json_decode(file_get_contents($name));
	$bash = '';

	foreach ($data as $key => $val) {
		$bash .= strtoupper($key).'="'.$val.'"'.PHP_EOL;
	}

	$bash .= file_get_contents('json.sh');

	return $bash;
}

// return helper as bash file
function helper_get_contents($list) {
	$grid = array();
	$list = trim(urldecode($list)) ? explode(' ', trim(urldecode($list))) : array();
	$bash = '';

	foreach (glob('json/*') as $name) {
		$name = basename($name, '.json');

		if (empty($list)) {
			array_push($grid, $name);
		} else {
			foreach ($list as $each) {
				if (preg_match('/'.preg_quote($each).'/', $name)) {
					array_push($grid, $name);

					break 1;
				}
			}
		}
	}

	if (count($grid)) {
		$bash .= 'APPS="· '.implode('\n· ', $grid).'"'.PHP_EOL.PHP_EOL;
	}

	$bash .= file_get_contents('help.sh');

	return $bash;
}

function main() {
	// get url path
	$path = substr($_SERVER['DOCUMENT_ROOT'].(
		$_SERVER['QUERY_STRING'] || substr($_SERVER['REQUEST_URI'], -1) === '?' ? substr($_SERVER['REQUEST_URI'], 0, - 1 - strlen($_SERVER['QUERY_STRING'])) : $_SERVER['REQUEST_URI']
	), strlen(dirname(__FILE__)) + 1);

	// get user agent
	$user = $_SERVER['HTTP_USER_AGENT'];

	// if path is file
	if (file_exists($path)) {
		// exit as contents
		exit_set_contents(file_get_contents($path));
	}

	// if path is bash file
	if (file_exists('bash/'.$path.'.sh')) {
		// exit as bash
		exit_set_contents(file_get_contents('bash/'.$path.'.sh'));
	}

	// if path is json file
	if (file_exists('json/'.$path.'.json')) {
		// exit as installer bash
		exit_set_contents(json_get_contents('json/'.$path.'.json'));
	}

	// if path includes help request
	if (preg_match('/^help(.*)$/', $path, $matches)) {
		// exit as helper bash
		exit_set_contents(helper_get_contents(trim($matches[1])));
	}

	// if path is empty
	if (empty($path)) {
		// if user agent is empty or curl
		if (preg_match('/^$|^curl/', $user)) {
			// exit as readme bash contents
			exit_set_contents(file_get_contents('readme.sh'));
		}

		// exit as readme HTML
		exit_set_contents(file_get_contents('readme.html'), 'text/html');
	}
}

main();
