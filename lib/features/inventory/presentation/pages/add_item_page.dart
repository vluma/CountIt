import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:countit/features/home/domain/models/item.dart';
import 'package:countit/services/database_service.dart';

class AddItemPage extends ConsumerStatefulWidget {
  const AddItemPage({super.key});

  @override
  ConsumerState<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends ConsumerState<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  int _count = 1;
  List<String> _tags = [];
  DateTime? _expiryDate;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _saveItem() async {
    if (_formKey.currentState?.validate() ?? false) {
      final item = Item(
        name: _nameController.text,
        location: _locationController.text.isNotEmpty ? _locationController.text : null,
        count: _count,
        expiryDate: _expiryDate,
        tags: _tags.isNotEmpty ? _tags : null,
      );

      await DatabaseService().addItem(item);
      if (mounted) {
        context.pop();
      }
    }
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null && picked != _expiryDate) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  void _toggleTag(String tag) {
    setState(() {
      if (_tags.contains(tag)) {
        _tags.remove(tag);
      } else {
        _tags.add(tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 预设标签
    final presetTags = ['数码', '个人护理', '食品', '家居', '工具', '书籍'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text('新增物品'),
        actions: [
          TextButton(
            onPressed: _saveItem,
            child: const Text('保存', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 拍摄照片区域
                Center(
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_alt,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: () {
                                // 打开相机
                              },
                              child: const Text('📷 拍摄照片'),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '(自动识别中... 💡 吹风机)',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // 物品名称
                const Text('名称:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: '戴森吹风机',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入物品名称';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // 位置选择
                const Text('位置:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    hintText: '卧室 > 梳妆台 > 抽屉一',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                  readOnly: true,
                  onTap: () {
                    // 打开位置选择器
                  },
                ),
                
                const SizedBox(height: 16),
                
                // 数量调整
                const Text('数量:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (_count > 1) {
                            _count--;
                          }
                        });
                      },
                    ),
                    Container(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          _count.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _count++;
                        });
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // 标签选择
                const Text('标签:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: presetTags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      onDeleted: () => _toggleTag(tag),
                      deleteIcon: _tags.contains(tag) ? const Icon(Icons.close) : const Icon(Icons.add),
                      deleteIconColor: _tags.contains(tag) ? Colors.red : Colors.blue,
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 16),
                
                // 过期日期
                const Text('过期日期:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ListTile(
                  title: Text(
                    _expiryDate != null
                        ? '${_expiryDate!.year}-${_expiryDate!.month.toString().padLeft(2, '0')}-${_expiryDate!.day.toString().padLeft(2, '0')}'
                        : '2026-12-01',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: _selectDate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
