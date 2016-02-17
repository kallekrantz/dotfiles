from wunderlist.models.user import User
from wunderlist.util import workflow
from wunderlist import icons

def filter(args):
	current_user = User.get()

	if current_user and current_user.name:
		workflow().add_item(
			'Sign out',
			'You are logged in as ' + current_user.name,
			autocomplete=':logout', icon=icons.CANCEL
		)


	workflow().add_item(
		'Switch theme',
		'Toggle between light and dark icons',
		arg=':pref retheme',
		valid=True,
		icon=icons.PAINTBRUSH
	)

	workflow().add_item(
		'Force sync',
		'The workflow syncs automatically, but feel free to be forcible.',
		arg=':sync', valid=True, icon=icons.SYNC
	)

	workflow().add_item(
		'Update workflow',
		'Check for updates to the workflow (automatically checked periodically)',
		arg=':pref update', valid=True, icon=icons.DOWNLOAD
	)

	workflow().add_item(
		'Main menu',
		autocomplete='', icon=icons.BACK
	)

def commit(args):
	if ':sync' in args:
		from wunderlist.sync import sync
		sync()
	elif 'update' in args:
		if workflow().start_update():
			print 'The workflow is being updated'
		else:
			print 'You already have the latest workflow version'
	elif 'retheme' in args:
		import subprocess

		prefs = workflow().stored_data('prefs')
		if not prefs:
			prefs = { 'icon_theme': 'dark' }

		prefs['icon_theme'] = 'light' if prefs['icon_theme'] == 'dark' else 'dark'

		workflow().store_data('prefs', prefs)

		print 'The workflow is now using the %s icon theme' % (prefs['icon_theme'])

		subprocess.call(['/usr/bin/env', 'osascript', 'bin/launch_alfred.scpt', 'wl:pref'])