import 'package:flutter/foundation.dart';

import 'package:test_project_insta_clone/views/components/constants/strings.dart';
import 'package:test_project_insta_clone/views/components/dialogs/alert_dialog_model.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  DeleteDialog({required titleOfObjectTobeDeleted})
      : super(
            title: '${Strings.delete} $titleOfObjectTobeDeleted?',
            message:
                '${Strings.areYouSureYouWantToDeleteThis} $titleOfObjectTobeDeleted?',
            buttons: {
              Strings.cancel: false,
              Strings.delete: true,
            });
}
