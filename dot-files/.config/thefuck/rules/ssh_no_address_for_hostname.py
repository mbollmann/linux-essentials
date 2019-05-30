import re
import os
from thefuck.utils import for_app, get_closest

commands = ('ssh', 'scp', 'rsync', 'git')

@for_app(*commands)
def match(command):
    return ('No address associated with hostname' in command.stderr
            and 'Could not resolve hostname' in command.stderr)

def get_new_command(command):
    ssh_config = os.path.expanduser("~/.ssh/config")
    if not os.path.exists(ssh_config):
        return
    known_hosts = _get_known_hosts(ssh_config)
    match = re.search("Could not resolve hostname (.*): No address", command.stderr)
    if match:
        tried_host = match.group(1)
        closest_host = get_closest(tried_host, known_hosts, fallback_to_first=False)
        return _replace_ssh_host(command.script, tried_host, closest_host)

def _get_known_hosts(ssh_config):
    known_hosts = []
    with open(ssh_config, 'r') as f:
        for line in f:
            line = line.strip()
            if line.startswith("Host "):
                known_hosts.append(line[5:])
    return known_hosts

def _replace_ssh_host(script, from_, to):
    replaced_in_the_end = re.sub(u' {}$'.format(re.escape(from_)), u' {}'.format(to),
                                 script, count=1)
    if replaced_in_the_end != script:
        return replaced_in_the_end
    else:
        return re.sub(u' {}([/:]?)'.format(from_), u' {}\\1'.format(to),
                      script, count=1)

