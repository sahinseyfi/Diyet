def test_packages_import():
    import importlib

    # Importing should execute __init__ files for coverage
    importlib.import_module("src.api")
    importlib.import_module("src.schemas")
    importlib.import_module("src.services")

    assert True
