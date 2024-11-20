import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/pegawai_controller.dart';
import 'package:test_task/pages/form_add_pegawai.dart';
import 'package:test_task/pages/form_edit_pegawai.dart';
import 'package:test_task/service/api_service.dart';
import 'package:test_task/widget/alert_dialog.dart';

class EmployeeListView extends StatelessWidget {
  EmployeeListView() {
    if (!Get.isRegistered<ApiService>()) {
      Get.put(ApiService());
    }
    if (!Get.isRegistered<EmployeeController>()) {
      Get.put(EmployeeController());
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmployeeController>();

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 51, 102, 1.0),
        foregroundColor: Colors.white,
        title: Text(
          'Employee List',
          style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: Obx(
            () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: controller.employees.length,
          itemBuilder: (context, index) {
            final employee = controller.employees[index];
            return Dismissible(
              key: Key(employee.id.toString()),
              background: Container(
                color: Colors.red[700],
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Delete',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteConfirmationDialog(
                      employeeName: employee.nama ?? '',
                    );
                  },
                );
              },
              onDismissed: (direction) {
                controller.deleteEmployee(employee.id!);
              },
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Get.to(() => EmployeeEditForm(employee: employee));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://i.pinimg.com/736x/77/2a/a7/772aa709423494dba2e436c8df1fe643.jpg'),
                    ),
                    title: Text(
                      employee.nama ?? '',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${employee.kabupaten?.name ?? ''}, ${employee.provinsi?.name ?? ''}',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[700],
                              fontSize: 12
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 1,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 51, 102, 1.0),
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: () {
          Get.to(() => EmployeeAddForm());
        },
      ),
    );
  }
}