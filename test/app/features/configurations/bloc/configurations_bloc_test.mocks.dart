// Mocks generated by Mockito 5.4.4 from annotations
// in crono_cube/test/app/features/configurations/bloc/configurations_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:crono_cube/app/features/configurations/models/configurations.dart'
    as _i2;
import 'package:crono_cube/database/daos/configurations_dao.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeConfigurations_0 extends _i1.SmartFake
    implements _i2.Configurations {
  _FakeConfigurations_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ConfigurationsDao].
///
/// See the documentation for Mockito's code generation for more information.
class MockConfigurationsDao extends _i1.Mock implements _i3.ConfigurationsDao {
  @override
  _i4.Future<_i2.Configurations> getConfigurations() => (super.noSuchMethod(
        Invocation.method(
          #getConfigurations,
          [],
        ),
        returnValue: _i4.Future<_i2.Configurations>.value(_FakeConfigurations_0(
          this,
          Invocation.method(
            #getConfigurations,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Configurations>.value(_FakeConfigurations_0(
          this,
          Invocation.method(
            #getConfigurations,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Configurations>);

  @override
  _i4.Future<bool> updateConfigurations(_i2.Configurations? configurations) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateConfigurations,
          [configurations],
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
