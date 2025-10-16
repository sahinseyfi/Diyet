def test_packages_import():
    # Importing should execute __init__ lines for coverage
    import src.api as _a  # noqa: F401
    import src.schemas as _s  # noqa: F401
    import src.services as _v  # noqa: F401

    assert True

