# SPDX-License-Identifier: MIT

# Suppress duplicate unit-address warnings for power, clock, acl, flash-controller.
list(APPEND EXTRA_DTC_FLAGS "-Wno-unique_unit_address_if_enabled")
