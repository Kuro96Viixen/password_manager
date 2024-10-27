import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/constants/routes.dart';
import 'package:password_manager/core/navigation_service.dart';
import 'package:password_manager/data/memory_data_source/memory_data_source.dart';
import 'package:password_manager/data/repository/data_source/memory_data_source.dart';
import 'package:password_manager/data/repository/repository_impl.dart';
import 'package:password_manager/data/repository/services/file_picker_service.dart';
import 'package:password_manager/data/repository/services/local_auth_service.dart';
import 'package:password_manager/data/repository/services/secure_storage_service.dart';
import 'package:password_manager/data/services/file_picker_service.dart';
import 'package:password_manager/data/services/local_auth_service.dart';
import 'package:password_manager/data/services/secure_storage_service.dart';
import 'package:password_manager/domain/repository/repository.dart';
import 'package:password_manager/domain/use_cases/export_accounts_use_case.dart';
import 'package:password_manager/domain/use_cases/get_accounts_data_from_storage_use_case.dart';
import 'package:password_manager/domain/use_cases/get_accounts_data_use_case.dart';
import 'package:password_manager/domain/use_cases/get_authentication_use_case.dart';
import 'package:password_manager/domain/use_cases/import_accounts_use_case.dart';
import 'package:password_manager/domain/use_cases/set_accounts_data_on_storage_use_case.dart';
import 'package:password_manager/domain/use_cases/set_accounts_data_use_case.dart';
import 'package:password_manager/ui/accounts/accounts_view.dart';
import 'package:password_manager/ui/accounts/bloc/accounts_bloc.dart';
import 'package:password_manager/ui/details/bloc/details_bloc.dart';
import 'package:password_manager/ui/modify/bloc/modify_bloc.dart';

part 'modules/domain_modules.dart';
part 'modules/local_modules.dart';
part 'modules/navigation_modules.dart';
part 'modules/repository_modules.dart';
part 'modules/ui_modules.dart';

void init() {
  _domainModulesInit();
  _localModulesInit();
  _navigationModulesInit();
  _repositoryModulesDi();
  _uiModulesInit();
}
