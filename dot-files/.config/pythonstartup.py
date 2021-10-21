import sys
sys.ps1 = " > "
sys.ps2 = "   "

def fallback_pprint_hook(pprint, value):
    if value != None:
        __builtins__._ = value
        pprint(value)

try:
    from rich import pretty, inspect, traceback
    from rich import print as pprint
    pretty.install()
    _ = traceback.install()
    del _
except ImportError:
    try:
        from pprint import pprint
        sys.displayhook = lambda value: fallback_pprint_hook(pprint, value)
    except ImportError:
        pass
