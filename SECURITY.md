# Security Policy

## Supported Versions

Use this section to tell people about which versions of your project are
currently being supported with security updates.

| Version | Supported          |
| ------- | ------------------ |
| 5.1.x   | :white_check_mark: |
| 5.0.x   | :x:                |
| 4.0.x   | :white_check_mark: |
| < 4.0   | :x:                |

## Reporting a Vulnerability

Use this section to tell people how to report a vulnerability.

Tell them where to go, how often they can expect to get an update on a
reported vulnerability, what to expect if the vulnerability is accepted or
declined, etc.
# -*- coding: utf-8 -*- #
# Copyright 2019 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Common classes and functions for organization security policy rules."""

from __future__ import absolute_import
from __future__ import division
from __future__ import unicode_literals

import re
from googlecloudsdk.calliope import exceptions as calliope_exceptions

ALLOWED_METAVAR = 'PROTOCOL[:PORT[-PORT]]'
LEGAL_SPECS = re.compile(
    r"""

    (?P<protocol>[a-zA-Z0-9+.-]+) # The protocol group.

    (:(?P<ports>\d+(-\d+)?))?     # The optional ports group.
                                  # May specify a range.

    $                             # End of input marker.
    """, re.VERBOSE)


def ParseDestPorts(dest_ports, message_classes):
  """Parses protocol:port mappings for --dest-ports command line."""
  dest_port_list = []
  for spec in dest_ports or []:
    match = LEGAL_SPECS.match(spec)
    if not match:
      raise calliope_exceptions.ToolException(
          'Organization security policy rules must be of the form {0}; received [{1}].'
          .format(ALLOWED_METAVAR, spec))
    if match.group('ports'):
      ports = [match.group('ports')]
    else:
      ports = []
    dest_port = message_classes.SecurityPolicyRuleMatcherConfigDestinationPort(
        ipProtocol=match.group('protocol'), ports=ports)
    dest_port_list.append(dest_port)
  return dest_port_list


def ConvertPriorityToInt(priority):
  try:
    int_priority = int(priority)
  except ValueError:
    raise calliope_exceptions.InvalidArgumentException(
        'priority', 'priority must be a valid non-negative integer.')
  if int_priority < 0:
    raise calliope_exceptions.InvalidArgumentException(
        'priority', 'priority must be a valid non-negative integer.')
  return int_priority
