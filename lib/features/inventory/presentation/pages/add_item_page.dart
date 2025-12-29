import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
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
  
  // 语音识别相关（暂时禁用）
  // stt.SpeechToText? _speech;
  // bool _isListening = false;
  // String _speechResult = '';
  
  // 拍照相关
  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  String _aiDetectionStatus = '';

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _speech = stt.SpeechToText();
  }

  /*
  Future<void> _toggleListening() async {
    if (!_isListening) {
      bool available = await _speech?.initialize() ?? false;
      if (available) {
        setState(() => _isListening = true);
        _speech?.listen(
          onResult: (result) {
            setState(() {
              _speechResult = result.recognizedWords;
              _nameController.text = _speechResult;
            });
          },
          listenFor: const Duration(seconds: 10),
          pauseFor: const Duration(seconds: 3),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech?.stop();
    }
  }
  */
  
  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _pickedImage = photo;
      });
      // 模拟AI识别商品信息
      _simulateAIDetection();
    }
  }
  
  void _simulateAIDetection() {
    // 开始识别
    setState(() {
      _aiDetectionStatus = '识别中...';
    });
    
    // 模拟AI识别延迟
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        // 模拟识别结果
        _nameController.text = '戴森吹风机 V12';
        _count = 1;
        _tags = ['数码'];
        _expiryDate = DateTime.now().add(const Duration(days: 365 * 2));
        _aiDetectionStatus = '识别完成';
      });
    });
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
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // 显示拍摄的照片
                          if (_pickedImage != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.file(
                                File(_pickedImage!.path),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          
                          // 中央拍摄按钮和信息
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_pickedImage == null)
                                  const Icon(
                                    Icons.camera_alt,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                const SizedBox(height: 12),
                                TextButton(
                                  onPressed: _takePhoto,
                                  child: Text(
                                    _pickedImage != null ? '📷 重新拍摄' : '📷 拍摄照片',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (_aiDetectionStatus == '识别中...')
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 16,
                                        height: 16,
                                        margin: const EdgeInsets.only(right: 8),
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        _aiDetectionStatus,
                                        style: const TextStyle(fontSize: 14, color: Colors.blue),
                                      ),
                                    ],
                                  )
                                else
                                  if (_aiDetectionStatus.isNotEmpty)
                                    Text(
                                      _aiDetectionStatus,
                                      style: const TextStyle(fontSize: 14, color: Colors.blue),
                                    )
                                  else
                                    if (_pickedImage != null)
                                      const Text(
                                        '识别完成',
                                        style: TextStyle(fontSize: 14, color: Colors.green),
                                      ),
                              ],
                            ),
                          ),
                        ],
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
