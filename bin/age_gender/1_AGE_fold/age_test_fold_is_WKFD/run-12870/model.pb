node {
  name: "batch_processing/input_producer/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 10
          }
        }
        string_val: "/home/ubuntu/age-gender/SeungChul/age_test_fold_is_0/train-00008-of-00010"
        string_val: "/home/ubuntu/age-gender/SeungChul/age_test_fold_is_0/train-00004-of-00010"
        string_val: "/home/ubuntu/age-gender/SeungChul/age_test_fold_is_0/train-00003-of-00010"
        string_val: "/home/ubuntu/age-gender/SeungChul/age_test_fold_is_0/train-00001-of-00010"
        string_val: "/home/ubuntu/age-gender/SeungChul/age_test_fold_is_0/train-00000-of-00010"
        string_val: "/home/ubuntu/age-gender/SeungChul/age_test_fold_is_0/train-00005-of-00010"
        string_val: "/home/ubuntu/age-gender/SeungChul/age_test_fold_is_0/train-00006-of-00010"
        string_val: "/home/ubuntu/age-gender/SeungChul/age_test_fold_is_0/train-00007-of-00010"
        string_val: "/home/ubuntu/age-gender/SeungChul/age_test_fold_is_0/train-00009-of-00010"
        string_val: "/home/ubuntu/age-gender/SeungChul/age_test_fold_is_0/train-00002-of-00010"
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/Size"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 10
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/Greater/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/Greater"
  op: "Greater"
  input: "batch_processing/input_producer/Size"
  input: "batch_processing/input_producer/Greater/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/input_producer/Assert/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "string_input_producer requires a non-null input tensor"
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/Assert/Assert/data_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "string_input_producer requires a non-null input tensor"
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/Assert/Assert"
  op: "Assert"
  input: "batch_processing/input_producer/Greater"
  input: "batch_processing/input_producer/Assert/Assert/data_0"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 3
    }
  }
}
node {
  name: "batch_processing/input_producer/Identity"
  op: "Identity"
  input: "batch_processing/input_producer/Const"
  input: "^batch_processing/input_producer/Assert/Assert"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
}
node {
  name: "batch_processing/input_producer/RandomShuffle"
  op: "RandomShuffle"
  input: "batch_processing/input_producer/Identity"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/input_producer"
  op: "FIFOQueueV2"
  device: "/device:CPU:0"
  attr {
    key: "capacity"
    value {
      i: 16
    }
  }
  attr {
    key: "component_types"
    value {
      list {
        type: DT_STRING
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "shapes"
    value {
      list {
        shape {
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "batch_processing/input_producer/input_producer_EnqueueMany"
  op: "QueueEnqueueManyV2"
  input: "batch_processing/input_producer"
  input: "batch_processing/input_producer/RandomShuffle"
  device: "/device:CPU:0"
  attr {
    key: "Tcomponents"
    value {
      list {
        type: DT_STRING
      }
    }
  }
  attr {
    key: "timeout_ms"
    value {
      i: -1
    }
  }
}
node {
  name: "batch_processing/input_producer/input_producer_Close"
  op: "QueueCloseV2"
  input: "batch_processing/input_producer"
  device: "/device:CPU:0"
  attr {
    key: "cancel_pending_enqueues"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/input_producer/input_producer_Close_1"
  op: "QueueCloseV2"
  input: "batch_processing/input_producer"
  device: "/device:CPU:0"
  attr {
    key: "cancel_pending_enqueues"
    value {
      b: true
    }
  }
}
node {
  name: "batch_processing/input_producer/input_producer_Size"
  op: "QueueSizeV2"
  input: "batch_processing/input_producer"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/input_producer/Cast"
  op: "Cast"
  input: "batch_processing/input_producer/input_producer_Size"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/input_producer/mul/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0625
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/mul"
  op: "Mul"
  input: "batch_processing/input_producer/Cast"
  input: "batch_processing/input_producer/mul/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/input_producer/fraction_of_16_full/tags"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "batch_processing/input_producer/fraction_of_16_full"
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/fraction_of_16_full"
  op: "ScalarSummary"
  input: "batch_processing/input_producer/fraction_of_16_full/tags"
  input: "batch_processing/input_producer/mul"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_shuffle_queue"
  op: "RandomShuffleQueueV2"
  device: "/device:CPU:0"
  attr {
    key: "capacity"
    value {
      i: 16768
    }
  }
  attr {
    key: "component_types"
    value {
      list {
        type: DT_STRING
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "min_after_dequeue"
    value {
      i: 16384
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
  attr {
    key: "shapes"
    value {
      list {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "batch_processing/TFRecordReaderV2"
  op: "TFRecordReaderV2"
  device: "/device:CPU:0"
  attr {
    key: "compression_type"
    value {
      s: ""
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "batch_processing/ReaderReadV2"
  op: "ReaderReadV2"
  input: "batch_processing/TFRecordReaderV2"
  input: "batch_processing/input_producer"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/ParseSingleExample/ExpandDims/dim"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ExpandDims"
  op: "ExpandDims"
  input: "batch_processing/ReaderReadV2:1"
  input: "batch_processing/ParseSingleExample/ExpandDims/dim"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/key_image/class/label"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/Reshape/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/Reshape"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample/ParseExample/key_image/class/label"
  input: "batch_processing/ParseSingleExample/ParseExample/Reshape/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/key_image/class/text"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/Reshape_1/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/Reshape_1"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample/ParseExample/key_image/class/text"
  input: "batch_processing/ParseSingleExample/ParseExample/Reshape_1/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/key_image/encoded"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/Reshape_2/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/Reshape_2"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample/ParseExample/key_image/encoded"
  input: "batch_processing/ParseSingleExample/ParseExample/Reshape_2/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/key_image/filename"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/Reshape_3/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/Reshape_3"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample/ParseExample/key_image/filename"
  input: "batch_processing/ParseSingleExample/ParseExample/Reshape_3/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/key_image/height"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/Reshape_4/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/Reshape_4"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample/ParseExample/key_image/height"
  input: "batch_processing/ParseSingleExample/ParseExample/Reshape_4/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/key_image/width"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/Reshape_5/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/Reshape_5"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample/ParseExample/key_image/width"
  input: "batch_processing/ParseSingleExample/ParseExample/Reshape_5/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/ParseExample/names"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/ParseExample/dense_keys_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/class/label"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/ParseExample/dense_keys_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/class/text"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/ParseExample/dense_keys_2"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/encoded"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/ParseExample/dense_keys_3"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/filename"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/ParseExample/dense_keys_4"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/height"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/ParseExample/dense_keys_5"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/width"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseExample/ParseExample"
  op: "ParseExample"
  input: "batch_processing/ParseSingleExample/ExpandDims"
  input: "batch_processing/ParseSingleExample/ParseExample/ParseExample/names"
  input: "batch_processing/ParseSingleExample/ParseExample/ParseExample/dense_keys_0"
  input: "batch_processing/ParseSingleExample/ParseExample/ParseExample/dense_keys_1"
  input: "batch_processing/ParseSingleExample/ParseExample/ParseExample/dense_keys_2"
  input: "batch_processing/ParseSingleExample/ParseExample/ParseExample/dense_keys_3"
  input: "batch_processing/ParseSingleExample/ParseExample/ParseExample/dense_keys_4"
  input: "batch_processing/ParseSingleExample/ParseExample/ParseExample/dense_keys_5"
  input: "batch_processing/ParseSingleExample/ParseExample/Reshape"
  input: "batch_processing/ParseSingleExample/ParseExample/Reshape_1"
  input: "batch_processing/ParseSingleExample/ParseExample/Reshape_2"
  input: "batch_processing/ParseSingleExample/ParseExample/Reshape_3"
  input: "batch_processing/ParseSingleExample/ParseExample/Reshape_4"
  input: "batch_processing/ParseSingleExample/ParseExample/Reshape_5"
  device: "/device:CPU:0"
  attr {
    key: "Ndense"
    value {
      i: 6
    }
  }
  attr {
    key: "Nsparse"
    value {
      i: 0
    }
  }
  attr {
    key: "Tdense"
    value {
      list {
        type: DT_INT64
        type: DT_STRING
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
        type: DT_INT64
      }
    }
  }
  attr {
    key: "dense_shapes"
    value {
      list {
        shape {
          dim {
            size: 1
          }
        }
        shape {
        }
        shape {
        }
        shape {
        }
        shape {
          dim {
            size: 1
          }
        }
        shape {
          dim {
            size: 1
          }
        }
      }
    }
  }
  attr {
    key: "sparse_types"
    value {
      list {
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Squeeze_image/class/label"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample/ParseExample/ParseExample"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Squeeze_image/class/text"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample/ParseExample/ParseExample:1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Squeeze_image/encoded"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample/ParseExample/ParseExample:2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Squeeze_image/filename"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample/ParseExample/ParseExample:3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Squeeze_image/height"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample/ParseExample/ParseExample:4"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Squeeze_image/width"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample/ParseExample/ParseExample:5"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/Cast"
  op: "Cast"
  input: "batch_processing/ParseSingleExample/Squeeze_image/class/label"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "batch_processing/decode_jpeg/DecodeJpeg"
  op: "DecodeJpeg"
  input: "batch_processing/ParseSingleExample/Squeeze_image/encoded"
  device: "/device:CPU:0"
  attr {
    key: "acceptable_fraction"
    value {
      f: 1.0
    }
  }
  attr {
    key: "channels"
    value {
      i: 3
    }
  }
  attr {
    key: "dct_method"
    value {
      s: ""
    }
  }
  attr {
    key: "fancy_upscaling"
    value {
      b: true
    }
  }
  attr {
    key: "ratio"
    value {
      i: 1
    }
  }
  attr {
    key: "try_recover_truncated"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg/convert_image/Cast"
  op: "Cast"
  input: "batch_processing/decode_jpeg/DecodeJpeg"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_UINT8
    }
  }
}
node {
  name: "batch_processing/decode_jpeg/convert_image/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00392156885937
      }
    }
  }
}
node {
  name: "batch_processing/decode_jpeg/convert_image"
  op: "Mul"
  input: "batch_processing/decode_jpeg/convert_image/Cast"
  input: "batch_processing/decode_jpeg/convert_image/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_crop/size"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/Shape"
  op: "Shape"
  input: "batch_processing/decode_jpeg/convert_image"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop/GreaterEqual"
  op: "GreaterEqual"
  input: "batch_processing/random_crop/Shape"
  input: "batch_processing/random_crop/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/All"
  op: "All"
  input: "batch_processing/random_crop/GreaterEqual"
  input: "batch_processing/random_crop/Const"
  device: "/device:CPU:0"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/random_crop/Assert/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/Assert/Assert/data_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/Assert/Assert"
  op: "Assert"
  input: "batch_processing/random_crop/All"
  input: "batch_processing/random_crop/Assert/Assert/data_0"
  input: "batch_processing/random_crop/Shape"
  input: "batch_processing/random_crop/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_INT32
        type: DT_INT32
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 1000
    }
  }
}
node {
  name: "batch_processing/random_crop/control_dependency"
  op: "Identity"
  input: "batch_processing/random_crop/Shape"
  input: "^batch_processing/random_crop/Assert/Assert"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop/Shape"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/sub"
  op: "Sub"
  input: "batch_processing/random_crop/control_dependency"
  input: "batch_processing/random_crop/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop/add/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/add"
  op: "Add"
  input: "batch_processing/random_crop/sub"
  input: "batch_processing/random_crop/add/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop/Shape_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2147483647
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/random_uniform"
  op: "RandomUniformInt"
  input: "batch_processing/random_crop/Shape_1"
  input: "batch_processing/random_crop/random_uniform/min"
  input: "batch_processing/random_crop/random_uniform/max"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tout"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_crop/mod"
  op: "FloorMod"
  input: "batch_processing/random_crop/random_uniform"
  input: "batch_processing/random_crop/add"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop"
  op: "Slice"
  input: "batch_processing/decode_jpeg/convert_image"
  input: "batch_processing/random_crop/mod"
  input: "batch_processing/random_crop/size"
  device: "/device:CPU:0"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/control_dependency"
  op: "Identity"
  input: "batch_processing/random_crop"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop"
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform/sub"
  op: "Sub"
  input: "batch_processing/random_uniform/max"
  input: "batch_processing/random_uniform/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform/mul"
  op: "Mul"
  input: "batch_processing/random_uniform/RandomUniform"
  input: "batch_processing/random_uniform/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform"
  op: "Add"
  input: "batch_processing/random_uniform/mul"
  input: "batch_processing/random_uniform/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Less/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.5
      }
    }
  }
}
node {
  name: "batch_processing/Less"
  op: "Less"
  input: "batch_processing/random_uniform"
  input: "batch_processing/Less/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/cond/Switch"
  op: "Switch"
  input: "batch_processing/Less"
  input: "batch_processing/Less"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond/switch_t"
  op: "Identity"
  input: "batch_processing/cond/Switch:1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond/switch_f"
  op: "Identity"
  input: "batch_processing/cond/Switch"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond/pred_id"
  op: "Identity"
  input: "batch_processing/Less"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond/ReverseV2/axis"
  op: "Const"
  input: "^batch_processing/cond/switch_t"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/cond/ReverseV2/Switch"
  op: "Switch"
  input: "batch_processing/control_dependency"
  input: "batch_processing/cond/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop"
      }
    }
  }
}
node {
  name: "batch_processing/cond/ReverseV2"
  op: "ReverseV2"
  input: "batch_processing/cond/ReverseV2/Switch:1"
  input: "batch_processing/cond/ReverseV2/axis"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/cond/Switch_1"
  op: "Switch"
  input: "batch_processing/control_dependency"
  input: "batch_processing/cond/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop"
      }
    }
  }
}
node {
  name: "batch_processing/cond/Merge"
  op: "Merge"
  input: "batch_processing/cond/Switch_1"
  input: "batch_processing/cond/ReverseV2"
  device: "/device:CPU:0"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_1/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_1/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_1/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_1/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_1/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_1/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_1/max"
  input: "batch_processing/random_uniform_1/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_1/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_1/RandomUniform"
  input: "batch_processing/random_uniform_1/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_1"
  op: "Add"
  input: "batch_processing/random_uniform_1/mul"
  input: "batch_processing/random_uniform_1/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness/Identity"
  op: "Identity"
  input: "batch_processing/cond/Merge"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness"
  op: "Add"
  input: "batch_processing/adjust_brightness/Identity"
  input: "batch_processing/random_uniform_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_brightness"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_2/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_2/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.20000000298
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_2/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.79999995232
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_2/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_2/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_2/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_2/max"
  input: "batch_processing/random_uniform_2/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_2/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_2/RandomUniform"
  input: "batch_processing/random_uniform_2/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_2"
  op: "Add"
  input: "batch_processing/random_uniform_2/mul"
  input: "batch_processing/random_uniform_2/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast/Identity"
  op: "Identity"
  input: "batch_processing/adjust_brightness/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast"
  op: "AdjustContrastv2"
  input: "batch_processing/adjust_contrast/Identity"
  input: "batch_processing/random_uniform_2"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/adjust_contrast/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_contrast"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/control_dependency_1"
  op: "Identity"
  input: "batch_processing/adjust_contrast/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/adjust_contrast/Identity_1"
      }
    }
  }
}
node {
  name: "batch_processing/Shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/Prod"
  op: "Prod"
  input: "batch_processing/Shape"
  input: "batch_processing/Const"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/Const_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\000\000\000\000\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Mean"
  op: "Mean"
  input: "batch_processing/control_dependency_1"
  input: "batch_processing/Const_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/Square"
  op: "Square"
  input: "batch_processing/control_dependency_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Const_2"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\000\000\000\000\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Mean_1"
  op: "Mean"
  input: "batch_processing/Square"
  input: "batch_processing/Const_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/Square_1"
  op: "Square"
  input: "batch_processing/Mean"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/sub"
  op: "Sub"
  input: "batch_processing/Mean_1"
  input: "batch_processing/Square_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Relu"
  op: "Relu"
  input: "batch_processing/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Sqrt"
  op: "Sqrt"
  input: "batch_processing/Relu"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Cast_2"
  op: "Cast"
  input: "batch_processing/Prod"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/Rsqrt"
  op: "Rsqrt"
  input: "batch_processing/Cast_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Maximum"
  op: "Maximum"
  input: "batch_processing/Sqrt"
  input: "batch_processing/Rsqrt"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Sub"
  op: "Sub"
  input: "batch_processing/control_dependency_1"
  input: "batch_processing/Mean"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/div"
  op: "RealDiv"
  input: "batch_processing/Sub"
  input: "batch_processing/Maximum"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ExpandDims/dim"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ExpandDims"
  op: "ExpandDims"
  input: "batch_processing/ReaderReadV2:1"
  input: "batch_processing/ParseSingleExample_1/ExpandDims/dim"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/key_image/class/label"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/Reshape/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/Reshape"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_1/ParseExample/key_image/class/label"
  input: "batch_processing/ParseSingleExample_1/ParseExample/Reshape/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/key_image/class/text"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_1/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_1"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_1/ParseExample/key_image/class/text"
  input: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_1/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/key_image/encoded"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_2/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_2"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_1/ParseExample/key_image/encoded"
  input: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_2/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/key_image/filename"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_3/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_3"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_1/ParseExample/key_image/filename"
  input: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_3/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/key_image/height"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_4/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_4"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_1/ParseExample/key_image/height"
  input: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_4/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/key_image/width"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_5/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_5"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_1/ParseExample/key_image/width"
  input: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_5/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/names"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/dense_keys_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/class/label"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/dense_keys_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/class/text"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/dense_keys_2"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/encoded"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/dense_keys_3"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/filename"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/dense_keys_4"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/height"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/dense_keys_5"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/width"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample"
  op: "ParseExample"
  input: "batch_processing/ParseSingleExample_1/ExpandDims"
  input: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/names"
  input: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/dense_keys_0"
  input: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/dense_keys_1"
  input: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/dense_keys_2"
  input: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/dense_keys_3"
  input: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/dense_keys_4"
  input: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample/dense_keys_5"
  input: "batch_processing/ParseSingleExample_1/ParseExample/Reshape"
  input: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_1"
  input: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_2"
  input: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_3"
  input: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_4"
  input: "batch_processing/ParseSingleExample_1/ParseExample/Reshape_5"
  device: "/device:CPU:0"
  attr {
    key: "Ndense"
    value {
      i: 6
    }
  }
  attr {
    key: "Nsparse"
    value {
      i: 0
    }
  }
  attr {
    key: "Tdense"
    value {
      list {
        type: DT_INT64
        type: DT_STRING
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
        type: DT_INT64
      }
    }
  }
  attr {
    key: "dense_shapes"
    value {
      list {
        shape {
          dim {
            size: 1
          }
        }
        shape {
        }
        shape {
        }
        shape {
        }
        shape {
          dim {
            size: 1
          }
        }
        shape {
          dim {
            size: 1
          }
        }
      }
    }
  }
  attr {
    key: "sparse_types"
    value {
      list {
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Squeeze_image/class/label"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Squeeze_image/class/text"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample:1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Squeeze_image/encoded"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample:2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Squeeze_image/filename"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample:3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Squeeze_image/height"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample:4"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Squeeze_image/width"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_1/ParseExample/ParseExample:5"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/Cast_3"
  op: "Cast"
  input: "batch_processing/ParseSingleExample_1/Squeeze_image/class/label"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_1/DecodeJpeg"
  op: "DecodeJpeg"
  input: "batch_processing/ParseSingleExample_1/Squeeze_image/encoded"
  device: "/device:CPU:0"
  attr {
    key: "acceptable_fraction"
    value {
      f: 1.0
    }
  }
  attr {
    key: "channels"
    value {
      i: 3
    }
  }
  attr {
    key: "dct_method"
    value {
      s: ""
    }
  }
  attr {
    key: "fancy_upscaling"
    value {
      b: true
    }
  }
  attr {
    key: "ratio"
    value {
      i: 1
    }
  }
  attr {
    key: "try_recover_truncated"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_1/convert_image/Cast"
  op: "Cast"
  input: "batch_processing/decode_jpeg_1/DecodeJpeg"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_UINT8
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_1/convert_image/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00392156885937
      }
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_1/convert_image"
  op: "Mul"
  input: "batch_processing/decode_jpeg_1/convert_image/Cast"
  input: "batch_processing/decode_jpeg_1/convert_image/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_crop_1/size"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/Shape"
  op: "Shape"
  input: "batch_processing/decode_jpeg_1/convert_image"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_1/GreaterEqual"
  op: "GreaterEqual"
  input: "batch_processing/random_crop_1/Shape"
  input: "batch_processing/random_crop_1/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_1/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/All"
  op: "All"
  input: "batch_processing/random_crop_1/GreaterEqual"
  input: "batch_processing/random_crop_1/Const"
  device: "/device:CPU:0"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/random_crop_1/Assert/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/Assert/Assert/data_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/Assert/Assert"
  op: "Assert"
  input: "batch_processing/random_crop_1/All"
  input: "batch_processing/random_crop_1/Assert/Assert/data_0"
  input: "batch_processing/random_crop_1/Shape"
  input: "batch_processing/random_crop_1/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_INT32
        type: DT_INT32
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 1000
    }
  }
}
node {
  name: "batch_processing/random_crop_1/control_dependency"
  op: "Identity"
  input: "batch_processing/random_crop_1/Shape"
  input: "^batch_processing/random_crop_1/Assert/Assert"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_1/Shape"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/sub"
  op: "Sub"
  input: "batch_processing/random_crop_1/control_dependency"
  input: "batch_processing/random_crop_1/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_1/add/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/add"
  op: "Add"
  input: "batch_processing/random_crop_1/sub"
  input: "batch_processing/random_crop_1/add/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_1/Shape_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2147483647
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/random_uniform"
  op: "RandomUniformInt"
  input: "batch_processing/random_crop_1/Shape_1"
  input: "batch_processing/random_crop_1/random_uniform/min"
  input: "batch_processing/random_crop_1/random_uniform/max"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tout"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_crop_1/mod"
  op: "FloorMod"
  input: "batch_processing/random_crop_1/random_uniform"
  input: "batch_processing/random_crop_1/add"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_1"
  op: "Slice"
  input: "batch_processing/decode_jpeg_1/convert_image"
  input: "batch_processing/random_crop_1/mod"
  input: "batch_processing/random_crop_1/size"
  device: "/device:CPU:0"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/control_dependency_2"
  op: "Identity"
  input: "batch_processing/random_crop_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_1"
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_3/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_3/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_3/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_3/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_3/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_3/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_3/max"
  input: "batch_processing/random_uniform_3/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_3/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_3/RandomUniform"
  input: "batch_processing/random_uniform_3/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_3"
  op: "Add"
  input: "batch_processing/random_uniform_3/mul"
  input: "batch_processing/random_uniform_3/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Less_1/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.5
      }
    }
  }
}
node {
  name: "batch_processing/Less_1"
  op: "Less"
  input: "batch_processing/random_uniform_3"
  input: "batch_processing/Less_1/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/cond_1/Switch"
  op: "Switch"
  input: "batch_processing/Less_1"
  input: "batch_processing/Less_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond_1/switch_t"
  op: "Identity"
  input: "batch_processing/cond_1/Switch:1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond_1/switch_f"
  op: "Identity"
  input: "batch_processing/cond_1/Switch"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond_1/pred_id"
  op: "Identity"
  input: "batch_processing/Less_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond_1/ReverseV2/axis"
  op: "Const"
  input: "^batch_processing/cond_1/switch_t"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/cond_1/ReverseV2/Switch"
  op: "Switch"
  input: "batch_processing/control_dependency_2"
  input: "batch_processing/cond_1/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_1"
      }
    }
  }
}
node {
  name: "batch_processing/cond_1/ReverseV2"
  op: "ReverseV2"
  input: "batch_processing/cond_1/ReverseV2/Switch:1"
  input: "batch_processing/cond_1/ReverseV2/axis"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/cond_1/Switch_1"
  op: "Switch"
  input: "batch_processing/control_dependency_2"
  input: "batch_processing/cond_1/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_1"
      }
    }
  }
}
node {
  name: "batch_processing/cond_1/Merge"
  op: "Merge"
  input: "batch_processing/cond_1/Switch_1"
  input: "batch_processing/cond_1/ReverseV2"
  device: "/device:CPU:0"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_4/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_4/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_4/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_4/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_4/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_4/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_4/max"
  input: "batch_processing/random_uniform_4/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_4/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_4/RandomUniform"
  input: "batch_processing/random_uniform_4/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_4"
  op: "Add"
  input: "batch_processing/random_uniform_4/mul"
  input: "batch_processing/random_uniform_4/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_1/Identity"
  op: "Identity"
  input: "batch_processing/cond_1/Merge"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_1"
  op: "Add"
  input: "batch_processing/adjust_brightness_1/Identity"
  input: "batch_processing/random_uniform_4"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_1/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_brightness_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_5/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_5/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.20000000298
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_5/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.79999995232
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_5/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_5/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_5/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_5/max"
  input: "batch_processing/random_uniform_5/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_5/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_5/RandomUniform"
  input: "batch_processing/random_uniform_5/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_5"
  op: "Add"
  input: "batch_processing/random_uniform_5/mul"
  input: "batch_processing/random_uniform_5/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast_1/Identity"
  op: "Identity"
  input: "batch_processing/adjust_brightness_1/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast_1"
  op: "AdjustContrastv2"
  input: "batch_processing/adjust_contrast_1/Identity"
  input: "batch_processing/random_uniform_5"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/adjust_contrast_1/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_contrast_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/control_dependency_3"
  op: "Identity"
  input: "batch_processing/adjust_contrast_1/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/adjust_contrast_1/Identity_1"
      }
    }
  }
}
node {
  name: "batch_processing/Shape_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Const_3"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/Prod_1"
  op: "Prod"
  input: "batch_processing/Shape_1"
  input: "batch_processing/Const_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/Const_4"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\000\000\000\000\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Mean_2"
  op: "Mean"
  input: "batch_processing/control_dependency_3"
  input: "batch_processing/Const_4"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/Square_2"
  op: "Square"
  input: "batch_processing/control_dependency_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Const_5"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\000\000\000\000\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Mean_3"
  op: "Mean"
  input: "batch_processing/Square_2"
  input: "batch_processing/Const_5"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/Square_3"
  op: "Square"
  input: "batch_processing/Mean_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/sub_1"
  op: "Sub"
  input: "batch_processing/Mean_3"
  input: "batch_processing/Square_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Relu_1"
  op: "Relu"
  input: "batch_processing/sub_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Sqrt_1"
  op: "Sqrt"
  input: "batch_processing/Relu_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Cast_5"
  op: "Cast"
  input: "batch_processing/Prod_1"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/Rsqrt_1"
  op: "Rsqrt"
  input: "batch_processing/Cast_5"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Maximum_1"
  op: "Maximum"
  input: "batch_processing/Sqrt_1"
  input: "batch_processing/Rsqrt_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Sub_1"
  op: "Sub"
  input: "batch_processing/control_dependency_3"
  input: "batch_processing/Mean_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/div_1"
  op: "RealDiv"
  input: "batch_processing/Sub_1"
  input: "batch_processing/Maximum_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ExpandDims/dim"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ExpandDims"
  op: "ExpandDims"
  input: "batch_processing/ReaderReadV2:1"
  input: "batch_processing/ParseSingleExample_2/ExpandDims/dim"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/key_image/class/label"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/Reshape/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/Reshape"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_2/ParseExample/key_image/class/label"
  input: "batch_processing/ParseSingleExample_2/ParseExample/Reshape/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/key_image/class/text"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_1/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_1"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_2/ParseExample/key_image/class/text"
  input: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_1/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/key_image/encoded"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_2/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_2"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_2/ParseExample/key_image/encoded"
  input: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_2/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/key_image/filename"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_3/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_3"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_2/ParseExample/key_image/filename"
  input: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_3/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/key_image/height"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_4/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_4"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_2/ParseExample/key_image/height"
  input: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_4/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/key_image/width"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_5/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_5"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_2/ParseExample/key_image/width"
  input: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_5/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/names"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/dense_keys_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/class/label"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/dense_keys_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/class/text"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/dense_keys_2"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/encoded"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/dense_keys_3"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/filename"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/dense_keys_4"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/height"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/dense_keys_5"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/width"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample"
  op: "ParseExample"
  input: "batch_processing/ParseSingleExample_2/ExpandDims"
  input: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/names"
  input: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/dense_keys_0"
  input: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/dense_keys_1"
  input: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/dense_keys_2"
  input: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/dense_keys_3"
  input: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/dense_keys_4"
  input: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample/dense_keys_5"
  input: "batch_processing/ParseSingleExample_2/ParseExample/Reshape"
  input: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_1"
  input: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_2"
  input: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_3"
  input: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_4"
  input: "batch_processing/ParseSingleExample_2/ParseExample/Reshape_5"
  device: "/device:CPU:0"
  attr {
    key: "Ndense"
    value {
      i: 6
    }
  }
  attr {
    key: "Nsparse"
    value {
      i: 0
    }
  }
  attr {
    key: "Tdense"
    value {
      list {
        type: DT_INT64
        type: DT_STRING
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
        type: DT_INT64
      }
    }
  }
  attr {
    key: "dense_shapes"
    value {
      list {
        shape {
          dim {
            size: 1
          }
        }
        shape {
        }
        shape {
        }
        shape {
        }
        shape {
          dim {
            size: 1
          }
        }
        shape {
          dim {
            size: 1
          }
        }
      }
    }
  }
  attr {
    key: "sparse_types"
    value {
      list {
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Squeeze_image/class/label"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Squeeze_image/class/text"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample:1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Squeeze_image/encoded"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample:2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Squeeze_image/filename"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample:3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Squeeze_image/height"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample:4"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Squeeze_image/width"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_2/ParseExample/ParseExample:5"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/Cast_6"
  op: "Cast"
  input: "batch_processing/ParseSingleExample_2/Squeeze_image/class/label"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_2/DecodeJpeg"
  op: "DecodeJpeg"
  input: "batch_processing/ParseSingleExample_2/Squeeze_image/encoded"
  device: "/device:CPU:0"
  attr {
    key: "acceptable_fraction"
    value {
      f: 1.0
    }
  }
  attr {
    key: "channels"
    value {
      i: 3
    }
  }
  attr {
    key: "dct_method"
    value {
      s: ""
    }
  }
  attr {
    key: "fancy_upscaling"
    value {
      b: true
    }
  }
  attr {
    key: "ratio"
    value {
      i: 1
    }
  }
  attr {
    key: "try_recover_truncated"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_2/convert_image/Cast"
  op: "Cast"
  input: "batch_processing/decode_jpeg_2/DecodeJpeg"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_UINT8
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_2/convert_image/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00392156885937
      }
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_2/convert_image"
  op: "Mul"
  input: "batch_processing/decode_jpeg_2/convert_image/Cast"
  input: "batch_processing/decode_jpeg_2/convert_image/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_crop_2/size"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/Shape"
  op: "Shape"
  input: "batch_processing/decode_jpeg_2/convert_image"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_2/GreaterEqual"
  op: "GreaterEqual"
  input: "batch_processing/random_crop_2/Shape"
  input: "batch_processing/random_crop_2/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_2/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/All"
  op: "All"
  input: "batch_processing/random_crop_2/GreaterEqual"
  input: "batch_processing/random_crop_2/Const"
  device: "/device:CPU:0"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/random_crop_2/Assert/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/Assert/Assert/data_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/Assert/Assert"
  op: "Assert"
  input: "batch_processing/random_crop_2/All"
  input: "batch_processing/random_crop_2/Assert/Assert/data_0"
  input: "batch_processing/random_crop_2/Shape"
  input: "batch_processing/random_crop_2/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_INT32
        type: DT_INT32
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 1000
    }
  }
}
node {
  name: "batch_processing/random_crop_2/control_dependency"
  op: "Identity"
  input: "batch_processing/random_crop_2/Shape"
  input: "^batch_processing/random_crop_2/Assert/Assert"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_2/Shape"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/sub"
  op: "Sub"
  input: "batch_processing/random_crop_2/control_dependency"
  input: "batch_processing/random_crop_2/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_2/add/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/add"
  op: "Add"
  input: "batch_processing/random_crop_2/sub"
  input: "batch_processing/random_crop_2/add/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_2/Shape_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2147483647
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/random_uniform"
  op: "RandomUniformInt"
  input: "batch_processing/random_crop_2/Shape_1"
  input: "batch_processing/random_crop_2/random_uniform/min"
  input: "batch_processing/random_crop_2/random_uniform/max"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tout"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_crop_2/mod"
  op: "FloorMod"
  input: "batch_processing/random_crop_2/random_uniform"
  input: "batch_processing/random_crop_2/add"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_2"
  op: "Slice"
  input: "batch_processing/decode_jpeg_2/convert_image"
  input: "batch_processing/random_crop_2/mod"
  input: "batch_processing/random_crop_2/size"
  device: "/device:CPU:0"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/control_dependency_4"
  op: "Identity"
  input: "batch_processing/random_crop_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_2"
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_6/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_6/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_6/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_6/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_6/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_6/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_6/max"
  input: "batch_processing/random_uniform_6/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_6/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_6/RandomUniform"
  input: "batch_processing/random_uniform_6/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_6"
  op: "Add"
  input: "batch_processing/random_uniform_6/mul"
  input: "batch_processing/random_uniform_6/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Less_2/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.5
      }
    }
  }
}
node {
  name: "batch_processing/Less_2"
  op: "Less"
  input: "batch_processing/random_uniform_6"
  input: "batch_processing/Less_2/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/cond_2/Switch"
  op: "Switch"
  input: "batch_processing/Less_2"
  input: "batch_processing/Less_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond_2/switch_t"
  op: "Identity"
  input: "batch_processing/cond_2/Switch:1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond_2/switch_f"
  op: "Identity"
  input: "batch_processing/cond_2/Switch"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond_2/pred_id"
  op: "Identity"
  input: "batch_processing/Less_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond_2/ReverseV2/axis"
  op: "Const"
  input: "^batch_processing/cond_2/switch_t"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/cond_2/ReverseV2/Switch"
  op: "Switch"
  input: "batch_processing/control_dependency_4"
  input: "batch_processing/cond_2/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_2"
      }
    }
  }
}
node {
  name: "batch_processing/cond_2/ReverseV2"
  op: "ReverseV2"
  input: "batch_processing/cond_2/ReverseV2/Switch:1"
  input: "batch_processing/cond_2/ReverseV2/axis"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/cond_2/Switch_1"
  op: "Switch"
  input: "batch_processing/control_dependency_4"
  input: "batch_processing/cond_2/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_2"
      }
    }
  }
}
node {
  name: "batch_processing/cond_2/Merge"
  op: "Merge"
  input: "batch_processing/cond_2/Switch_1"
  input: "batch_processing/cond_2/ReverseV2"
  device: "/device:CPU:0"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_7/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_7/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_7/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_7/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_7/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_7/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_7/max"
  input: "batch_processing/random_uniform_7/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_7/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_7/RandomUniform"
  input: "batch_processing/random_uniform_7/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_7"
  op: "Add"
  input: "batch_processing/random_uniform_7/mul"
  input: "batch_processing/random_uniform_7/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_2/Identity"
  op: "Identity"
  input: "batch_processing/cond_2/Merge"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_2"
  op: "Add"
  input: "batch_processing/adjust_brightness_2/Identity"
  input: "batch_processing/random_uniform_7"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_2/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_brightness_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_8/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_8/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.20000000298
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_8/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.79999995232
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_8/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_8/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_8/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_8/max"
  input: "batch_processing/random_uniform_8/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_8/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_8/RandomUniform"
  input: "batch_processing/random_uniform_8/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_8"
  op: "Add"
  input: "batch_processing/random_uniform_8/mul"
  input: "batch_processing/random_uniform_8/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast_2/Identity"
  op: "Identity"
  input: "batch_processing/adjust_brightness_2/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast_2"
  op: "AdjustContrastv2"
  input: "batch_processing/adjust_contrast_2/Identity"
  input: "batch_processing/random_uniform_8"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/adjust_contrast_2/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_contrast_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/control_dependency_5"
  op: "Identity"
  input: "batch_processing/adjust_contrast_2/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/adjust_contrast_2/Identity_1"
      }
    }
  }
}
node {
  name: "batch_processing/Shape_2"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Const_6"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/Prod_2"
  op: "Prod"
  input: "batch_processing/Shape_2"
  input: "batch_processing/Const_6"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/Const_7"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\000\000\000\000\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Mean_4"
  op: "Mean"
  input: "batch_processing/control_dependency_5"
  input: "batch_processing/Const_7"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/Square_4"
  op: "Square"
  input: "batch_processing/control_dependency_5"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Const_8"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\000\000\000\000\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Mean_5"
  op: "Mean"
  input: "batch_processing/Square_4"
  input: "batch_processing/Const_8"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/Square_5"
  op: "Square"
  input: "batch_processing/Mean_4"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/sub_2"
  op: "Sub"
  input: "batch_processing/Mean_5"
  input: "batch_processing/Square_5"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Relu_2"
  op: "Relu"
  input: "batch_processing/sub_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Sqrt_2"
  op: "Sqrt"
  input: "batch_processing/Relu_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Cast_8"
  op: "Cast"
  input: "batch_processing/Prod_2"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/Rsqrt_2"
  op: "Rsqrt"
  input: "batch_processing/Cast_8"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Maximum_2"
  op: "Maximum"
  input: "batch_processing/Sqrt_2"
  input: "batch_processing/Rsqrt_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Sub_2"
  op: "Sub"
  input: "batch_processing/control_dependency_5"
  input: "batch_processing/Mean_4"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/div_2"
  op: "RealDiv"
  input: "batch_processing/Sub_2"
  input: "batch_processing/Maximum_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ExpandDims/dim"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ExpandDims"
  op: "ExpandDims"
  input: "batch_processing/ReaderReadV2:1"
  input: "batch_processing/ParseSingleExample_3/ExpandDims/dim"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/key_image/class/label"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/Reshape/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/Reshape"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_3/ParseExample/key_image/class/label"
  input: "batch_processing/ParseSingleExample_3/ParseExample/Reshape/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/key_image/class/text"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_1/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_1"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_3/ParseExample/key_image/class/text"
  input: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_1/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/key_image/encoded"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_2/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_2"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_3/ParseExample/key_image/encoded"
  input: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_2/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/key_image/filename"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_3/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_3"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_3/ParseExample/key_image/filename"
  input: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_3/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/key_image/height"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_4/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_4"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_3/ParseExample/key_image/height"
  input: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_4/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/key_image/width"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_5/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_5"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_3/ParseExample/key_image/width"
  input: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_5/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/names"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/dense_keys_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/class/label"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/dense_keys_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/class/text"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/dense_keys_2"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/encoded"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/dense_keys_3"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/filename"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/dense_keys_4"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/height"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/dense_keys_5"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "image/width"
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample"
  op: "ParseExample"
  input: "batch_processing/ParseSingleExample_3/ExpandDims"
  input: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/names"
  input: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/dense_keys_0"
  input: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/dense_keys_1"
  input: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/dense_keys_2"
  input: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/dense_keys_3"
  input: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/dense_keys_4"
  input: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample/dense_keys_5"
  input: "batch_processing/ParseSingleExample_3/ParseExample/Reshape"
  input: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_1"
  input: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_2"
  input: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_3"
  input: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_4"
  input: "batch_processing/ParseSingleExample_3/ParseExample/Reshape_5"
  device: "/device:CPU:0"
  attr {
    key: "Ndense"
    value {
      i: 6
    }
  }
  attr {
    key: "Nsparse"
    value {
      i: 0
    }
  }
  attr {
    key: "Tdense"
    value {
      list {
        type: DT_INT64
        type: DT_STRING
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
        type: DT_INT64
      }
    }
  }
  attr {
    key: "dense_shapes"
    value {
      list {
        shape {
          dim {
            size: 1
          }
        }
        shape {
        }
        shape {
        }
        shape {
        }
        shape {
          dim {
            size: 1
          }
        }
        shape {
          dim {
            size: 1
          }
        }
      }
    }
  }
  attr {
    key: "sparse_types"
    value {
      list {
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Squeeze_image/class/label"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Squeeze_image/class/text"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample:1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Squeeze_image/encoded"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample:2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Squeeze_image/filename"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample:3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Squeeze_image/height"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample:4"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Squeeze_image/width"
  op: "Squeeze"
  input: "batch_processing/ParseSingleExample_3/ParseExample/ParseExample:5"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "batch_processing/Cast_9"
  op: "Cast"
  input: "batch_processing/ParseSingleExample_3/Squeeze_image/class/label"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_3/DecodeJpeg"
  op: "DecodeJpeg"
  input: "batch_processing/ParseSingleExample_3/Squeeze_image/encoded"
  device: "/device:CPU:0"
  attr {
    key: "acceptable_fraction"
    value {
      f: 1.0
    }
  }
  attr {
    key: "channels"
    value {
      i: 3
    }
  }
  attr {
    key: "dct_method"
    value {
      s: ""
    }
  }
  attr {
    key: "fancy_upscaling"
    value {
      b: true
    }
  }
  attr {
    key: "ratio"
    value {
      i: 1
    }
  }
  attr {
    key: "try_recover_truncated"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_3/convert_image/Cast"
  op: "Cast"
  input: "batch_processing/decode_jpeg_3/DecodeJpeg"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_UINT8
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_3/convert_image/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00392156885937
      }
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_3/convert_image"
  op: "Mul"
  input: "batch_processing/decode_jpeg_3/convert_image/Cast"
  input: "batch_processing/decode_jpeg_3/convert_image/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_crop_3/size"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/Shape"
  op: "Shape"
  input: "batch_processing/decode_jpeg_3/convert_image"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_3/GreaterEqual"
  op: "GreaterEqual"
  input: "batch_processing/random_crop_3/Shape"
  input: "batch_processing/random_crop_3/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_3/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/All"
  op: "All"
  input: "batch_processing/random_crop_3/GreaterEqual"
  input: "batch_processing/random_crop_3/Const"
  device: "/device:CPU:0"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/random_crop_3/Assert/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/Assert/Assert/data_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/Assert/Assert"
  op: "Assert"
  input: "batch_processing/random_crop_3/All"
  input: "batch_processing/random_crop_3/Assert/Assert/data_0"
  input: "batch_processing/random_crop_3/Shape"
  input: "batch_processing/random_crop_3/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_INT32
        type: DT_INT32
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 1000
    }
  }
}
node {
  name: "batch_processing/random_crop_3/control_dependency"
  op: "Identity"
  input: "batch_processing/random_crop_3/Shape"
  input: "^batch_processing/random_crop_3/Assert/Assert"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_3/Shape"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/sub"
  op: "Sub"
  input: "batch_processing/random_crop_3/control_dependency"
  input: "batch_processing/random_crop_3/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_3/add/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/add"
  op: "Add"
  input: "batch_processing/random_crop_3/sub"
  input: "batch_processing/random_crop_3/add/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_3/Shape_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2147483647
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/random_uniform"
  op: "RandomUniformInt"
  input: "batch_processing/random_crop_3/Shape_1"
  input: "batch_processing/random_crop_3/random_uniform/min"
  input: "batch_processing/random_crop_3/random_uniform/max"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tout"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_crop_3/mod"
  op: "FloorMod"
  input: "batch_processing/random_crop_3/random_uniform"
  input: "batch_processing/random_crop_3/add"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_3"
  op: "Slice"
  input: "batch_processing/decode_jpeg_3/convert_image"
  input: "batch_processing/random_crop_3/mod"
  input: "batch_processing/random_crop_3/size"
  device: "/device:CPU:0"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/control_dependency_6"
  op: "Identity"
  input: "batch_processing/random_crop_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_3"
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_9/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_9/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_9/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_9/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_9/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_9/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_9/max"
  input: "batch_processing/random_uniform_9/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_9/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_9/RandomUniform"
  input: "batch_processing/random_uniform_9/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_9"
  op: "Add"
  input: "batch_processing/random_uniform_9/mul"
  input: "batch_processing/random_uniform_9/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Less_3/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.5
      }
    }
  }
}
node {
  name: "batch_processing/Less_3"
  op: "Less"
  input: "batch_processing/random_uniform_9"
  input: "batch_processing/Less_3/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/cond_3/Switch"
  op: "Switch"
  input: "batch_processing/Less_3"
  input: "batch_processing/Less_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond_3/switch_t"
  op: "Identity"
  input: "batch_processing/cond_3/Switch:1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond_3/switch_f"
  op: "Identity"
  input: "batch_processing/cond_3/Switch"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond_3/pred_id"
  op: "Identity"
  input: "batch_processing/Less_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/cond_3/ReverseV2/axis"
  op: "Const"
  input: "^batch_processing/cond_3/switch_t"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/cond_3/ReverseV2/Switch"
  op: "Switch"
  input: "batch_processing/control_dependency_6"
  input: "batch_processing/cond_3/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_3"
      }
    }
  }
}
node {
  name: "batch_processing/cond_3/ReverseV2"
  op: "ReverseV2"
  input: "batch_processing/cond_3/ReverseV2/Switch:1"
  input: "batch_processing/cond_3/ReverseV2/axis"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/cond_3/Switch_1"
  op: "Switch"
  input: "batch_processing/control_dependency_6"
  input: "batch_processing/cond_3/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_3"
      }
    }
  }
}
node {
  name: "batch_processing/cond_3/Merge"
  op: "Merge"
  input: "batch_processing/cond_3/Switch_1"
  input: "batch_processing/cond_3/ReverseV2"
  device: "/device:CPU:0"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_10/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_10/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_10/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_10/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_10/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_10/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_10/max"
  input: "batch_processing/random_uniform_10/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_10/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_10/RandomUniform"
  input: "batch_processing/random_uniform_10/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_10"
  op: "Add"
  input: "batch_processing/random_uniform_10/mul"
  input: "batch_processing/random_uniform_10/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_3/Identity"
  op: "Identity"
  input: "batch_processing/cond_3/Merge"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_3"
  op: "Add"
  input: "batch_processing/adjust_brightness_3/Identity"
  input: "batch_processing/random_uniform_10"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_3/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_brightness_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_11/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_11/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.20000000298
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_11/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.79999995232
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_11/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_11/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_11/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_11/max"
  input: "batch_processing/random_uniform_11/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_11/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_11/RandomUniform"
  input: "batch_processing/random_uniform_11/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_11"
  op: "Add"
  input: "batch_processing/random_uniform_11/mul"
  input: "batch_processing/random_uniform_11/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast_3/Identity"
  op: "Identity"
  input: "batch_processing/adjust_brightness_3/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast_3"
  op: "AdjustContrastv2"
  input: "batch_processing/adjust_contrast_3/Identity"
  input: "batch_processing/random_uniform_11"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/adjust_contrast_3/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_contrast_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/control_dependency_7"
  op: "Identity"
  input: "batch_processing/adjust_contrast_3/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/adjust_contrast_3/Identity_1"
      }
    }
  }
}
node {
  name: "batch_processing/Shape_3"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Const_9"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/Prod_3"
  op: "Prod"
  input: "batch_processing/Shape_3"
  input: "batch_processing/Const_9"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/Const_10"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\000\000\000\000\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Mean_6"
  op: "Mean"
  input: "batch_processing/control_dependency_7"
  input: "batch_processing/Const_10"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/Square_6"
  op: "Square"
  input: "batch_processing/control_dependency_7"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Const_11"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\000\000\000\000\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Mean_7"
  op: "Mean"
  input: "batch_processing/Square_6"
  input: "batch_processing/Const_11"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/Square_7"
  op: "Square"
  input: "batch_processing/Mean_6"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/sub_3"
  op: "Sub"
  input: "batch_processing/Mean_7"
  input: "batch_processing/Square_7"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Relu_3"
  op: "Relu"
  input: "batch_processing/sub_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Sqrt_3"
  op: "Sqrt"
  input: "batch_processing/Relu_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Cast_11"
  op: "Cast"
  input: "batch_processing/Prod_3"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/Rsqrt_3"
  op: "Rsqrt"
  input: "batch_processing/Cast_11"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Maximum_3"
  op: "Maximum"
  input: "batch_processing/Sqrt_3"
  input: "batch_processing/Rsqrt_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/Sub_3"
  op: "Sub"
  input: "batch_processing/control_dependency_7"
  input: "batch_processing/Mean_6"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/div_3"
  op: "RealDiv"
  input: "batch_processing/Sub_3"
  input: "batch_processing/Maximum_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/batch_join/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue"
  op: "FIFOQueueV2"
  device: "/device:CPU:0"
  attr {
    key: "capacity"
    value {
      i: 1024
    }
  }
  attr {
    key: "component_types"
    value {
      list {
        type: DT_FLOAT
        type: DT_INT32
        type: DT_STRING
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "shapes"
    value {
      list {
        shape {
          dim {
            size: 227
          }
          dim {
            size: 227
          }
          dim {
            size: 3
          }
        }
        shape {
          dim {
            size: 1
          }
        }
        shape {
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_enqueue"
  op: "QueueEnqueueV2"
  input: "batch_processing/batch_join/fifo_queue"
  input: "batch_processing/div"
  input: "batch_processing/Cast"
  input: "batch_processing/ParseSingleExample/Squeeze_image/filename"
  device: "/device:CPU:0"
  attr {
    key: "Tcomponents"
    value {
      list {
        type: DT_FLOAT
        type: DT_INT32
        type: DT_STRING
      }
    }
  }
  attr {
    key: "timeout_ms"
    value {
      i: -1
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_enqueue_1"
  op: "QueueEnqueueV2"
  input: "batch_processing/batch_join/fifo_queue"
  input: "batch_processing/div_1"
  input: "batch_processing/Cast_3"
  input: "batch_processing/ParseSingleExample_1/Squeeze_image/filename"
  device: "/device:CPU:0"
  attr {
    key: "Tcomponents"
    value {
      list {
        type: DT_FLOAT
        type: DT_INT32
        type: DT_STRING
      }
    }
  }
  attr {
    key: "timeout_ms"
    value {
      i: -1
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_enqueue_2"
  op: "QueueEnqueueV2"
  input: "batch_processing/batch_join/fifo_queue"
  input: "batch_processing/div_2"
  input: "batch_processing/Cast_6"
  input: "batch_processing/ParseSingleExample_2/Squeeze_image/filename"
  device: "/device:CPU:0"
  attr {
    key: "Tcomponents"
    value {
      list {
        type: DT_FLOAT
        type: DT_INT32
        type: DT_STRING
      }
    }
  }
  attr {
    key: "timeout_ms"
    value {
      i: -1
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_enqueue_3"
  op: "QueueEnqueueV2"
  input: "batch_processing/batch_join/fifo_queue"
  input: "batch_processing/div_3"
  input: "batch_processing/Cast_9"
  input: "batch_processing/ParseSingleExample_3/Squeeze_image/filename"
  device: "/device:CPU:0"
  attr {
    key: "Tcomponents"
    value {
      list {
        type: DT_FLOAT
        type: DT_INT32
        type: DT_STRING
      }
    }
  }
  attr {
    key: "timeout_ms"
    value {
      i: -1
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_Close"
  op: "QueueCloseV2"
  input: "batch_processing/batch_join/fifo_queue"
  device: "/device:CPU:0"
  attr {
    key: "cancel_pending_enqueues"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_Close_1"
  op: "QueueCloseV2"
  input: "batch_processing/batch_join/fifo_queue"
  device: "/device:CPU:0"
  attr {
    key: "cancel_pending_enqueues"
    value {
      b: true
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_Size"
  op: "QueueSizeV2"
  input: "batch_processing/batch_join/fifo_queue"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/batch_join/Cast"
  op: "Cast"
  input: "batch_processing/batch_join/fifo_queue_Size"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/batch_join/mul/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0009765625
      }
    }
  }
}
node {
  name: "batch_processing/batch_join/mul"
  op: "Mul"
  input: "batch_processing/batch_join/Cast"
  input: "batch_processing/batch_join/mul/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/batch_join/fraction_of_1024_full/tags"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "batch_processing/batch_join/fraction_of_1024_full"
      }
    }
  }
}
node {
  name: "batch_processing/batch_join/fraction_of_1024_full"
  op: "ScalarSummary"
  input: "batch_processing/batch_join/fraction_of_1024_full/tags"
  input: "batch_processing/batch_join/mul"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/batch_join/n"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 128
      }
    }
  }
}
node {
  name: "batch_processing/batch_join"
  op: "QueueDequeueManyV2"
  input: "batch_processing/batch_join/fifo_queue"
  input: "batch_processing/batch_join/n"
  device: "/device:CPU:0"
  attr {
    key: "component_types"
    value {
      list {
        type: DT_FLOAT
        type: DT_INT32
        type: DT_STRING
      }
    }
  }
  attr {
    key: "timeout_ms"
    value {
      i: -1
    }
  }
}
node {
  name: "batch_processing/Reshape/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\200\000\000\000\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Reshape"
  op: "Reshape"
  input: "batch_processing/batch_join"
  input: "batch_processing/Reshape/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/images/tag"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "batch_processing/images"
      }
    }
  }
}
node {
  name: "batch_processing/images"
  op: "ImageSummary"
  input: "batch_processing/images/tag"
  input: "batch_processing/Reshape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "bad_color"
    value {
      tensor {
        dtype: DT_UINT8
        tensor_shape {
          dim {
            size: 4
          }
        }
        int_val: 255
        int_val: 0
        int_val: 0
        int_val: 255
      }
    }
  }
  attr {
    key: "max_images"
    value {
      i: 20
    }
  }
}
node {
  name: "batch_processing/Reshape_1/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 128
      }
    }
  }
}
node {
  name: "batch_processing/Reshape_1"
  op: "Reshape"
  input: "batch_processing/batch_join:1"
  input: "batch_processing/Reshape_1/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "LeviHassner/conv1/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\007\000\000\000\007\000\000\000\003\000\000\000`\000\000\000"
      }
    }
  }
}
node {
  name: "LeviHassner/conv1/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassner/conv1/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "LeviHassner/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "LeviHassner/conv1/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "LeviHassner/conv1/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "LeviHassner/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  input: "LeviHassner/conv1/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv1/weights/Initializer/random_normal"
  op: "Add"
  input: "LeviHassner/conv1/weights/Initializer/random_normal/mul"
  input: "LeviHassner/conv1/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv1/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 7
        }
        dim {
          size: 7
        }
        dim {
          size: 3
        }
        dim {
          size: 96
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassner/conv1/weights/Assign"
  op: "Assign"
  input: "LeviHassner/conv1/weights"
  input: "LeviHassner/conv1/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassner/conv1/weights/read"
  op: "Identity"
  input: "LeviHassner/conv1/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv1/kernel/Regularizer/l2_regularizer/scale"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.000500000023749
      }
    }
  }
}
node {
  name: "LeviHassner/conv1/kernel/Regularizer/l2_regularizer/L2Loss"
  op: "L2Loss"
  input: "LeviHassner/conv1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv1/kernel/Regularizer/l2_regularizer"
  op: "Mul"
  input: "LeviHassner/conv1/kernel/Regularizer/l2_regularizer/scale"
  input: "LeviHassner/conv1/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv1/biases/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 96
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassner/conv1/biases"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 96
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassner/conv1/biases/Assign"
  op: "Assign"
  input: "LeviHassner/conv1/biases"
  input: "LeviHassner/conv1/biases/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassner/conv1/biases/read"
  op: "Identity"
  input: "LeviHassner/conv1/biases"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/biases"
      }
    }
  }
}
node {
  name: "LeviHassner/conv1/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\007\000\000\000\007\000\000\000\003\000\000\000`\000\000\000"
      }
    }
  }
}
node {
  name: "LeviHassner/conv1/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "LeviHassner/conv1/convolution"
  op: "Conv2D"
  input: "batch_processing/Reshape"
  input: "LeviHassner/conv1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 4
        i: 4
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassner/conv1/BiasAdd"
  op: "BiasAdd"
  input: "LeviHassner/conv1/convolution"
  input: "LeviHassner/conv1/biases/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "LeviHassner/conv1/Relu"
  op: "Relu"
  input: "LeviHassner/conv1/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassner/pool1/MaxPool"
  op: "MaxPool"
  input: "LeviHassner/conv1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 3
        i: 3
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "LeviHassner/norm1"
  op: "LRN"
  input: "LeviHassner/pool1/MaxPool"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "alpha"
    value {
      f: 9.99999974738e-05
    }
  }
  attr {
    key: "beta"
    value {
      f: 0.75
    }
  }
  attr {
    key: "bias"
    value {
      f: 1.0
    }
  }
  attr {
    key: "depth_radius"
    value {
      i: 5
    }
  }
}
node {
  name: "LeviHassner/conv2/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\005\000\000\000\005\000\000\000`\000\000\000\000\001\000\000"
      }
    }
  }
}
node {
  name: "LeviHassner/conv2/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassner/conv2/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "LeviHassner/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "LeviHassner/conv2/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "LeviHassner/conv2/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "LeviHassner/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  input: "LeviHassner/conv2/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv2/weights/Initializer/random_normal"
  op: "Add"
  input: "LeviHassner/conv2/weights/Initializer/random_normal/mul"
  input: "LeviHassner/conv2/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv2/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 5
        }
        dim {
          size: 5
        }
        dim {
          size: 96
        }
        dim {
          size: 256
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassner/conv2/weights/Assign"
  op: "Assign"
  input: "LeviHassner/conv2/weights"
  input: "LeviHassner/conv2/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassner/conv2/weights/read"
  op: "Identity"
  input: "LeviHassner/conv2/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv2/kernel/Regularizer/l2_regularizer/scale"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.000500000023749
      }
    }
  }
}
node {
  name: "LeviHassner/conv2/kernel/Regularizer/l2_regularizer/L2Loss"
  op: "L2Loss"
  input: "LeviHassner/conv2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv2/kernel/Regularizer/l2_regularizer"
  op: "Mul"
  input: "LeviHassner/conv2/kernel/Regularizer/l2_regularizer/scale"
  input: "LeviHassner/conv2/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv2/biases/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 256
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassner/conv2/biases"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 256
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassner/conv2/biases/Assign"
  op: "Assign"
  input: "LeviHassner/conv2/biases"
  input: "LeviHassner/conv2/biases/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassner/conv2/biases/read"
  op: "Identity"
  input: "LeviHassner/conv2/biases"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/biases"
      }
    }
  }
}
node {
  name: "LeviHassner/conv2/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\005\000\000\000\005\000\000\000`\000\000\000\000\001\000\000"
      }
    }
  }
}
node {
  name: "LeviHassner/conv2/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "LeviHassner/conv2/convolution"
  op: "Conv2D"
  input: "LeviHassner/norm1"
  input: "LeviHassner/conv2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassner/conv2/BiasAdd"
  op: "BiasAdd"
  input: "LeviHassner/conv2/convolution"
  input: "LeviHassner/conv2/biases/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "LeviHassner/conv2/Relu"
  op: "Relu"
  input: "LeviHassner/conv2/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassner/pool2/MaxPool"
  op: "MaxPool"
  input: "LeviHassner/conv2/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 3
        i: 3
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "LeviHassner/norm2"
  op: "LRN"
  input: "LeviHassner/pool2/MaxPool"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "alpha"
    value {
      f: 9.99999974738e-05
    }
  }
  attr {
    key: "beta"
    value {
      f: 0.75
    }
  }
  attr {
    key: "bias"
    value {
      f: 1.0
    }
  }
  attr {
    key: "depth_radius"
    value {
      i: 5
    }
  }
}
node {
  name: "LeviHassner/conv3/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\000\001\000\000\200\001\000\000"
      }
    }
  }
}
node {
  name: "LeviHassner/conv3/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassner/conv3/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "LeviHassner/conv3/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "LeviHassner/conv3/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "LeviHassner/conv3/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "LeviHassner/conv3/weights/Initializer/random_normal/RandomStandardNormal"
  input: "LeviHassner/conv3/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv3/weights/Initializer/random_normal"
  op: "Add"
  input: "LeviHassner/conv3/weights/Initializer/random_normal/mul"
  input: "LeviHassner/conv3/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv3/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 256
        }
        dim {
          size: 384
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassner/conv3/weights/Assign"
  op: "Assign"
  input: "LeviHassner/conv3/weights"
  input: "LeviHassner/conv3/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassner/conv3/weights/read"
  op: "Identity"
  input: "LeviHassner/conv3/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv3/kernel/Regularizer/l2_regularizer/scale"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.000500000023749
      }
    }
  }
}
node {
  name: "LeviHassner/conv3/kernel/Regularizer/l2_regularizer/L2Loss"
  op: "L2Loss"
  input: "LeviHassner/conv3/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv3/kernel/Regularizer/l2_regularizer"
  op: "Mul"
  input: "LeviHassner/conv3/kernel/Regularizer/l2_regularizer/scale"
  input: "LeviHassner/conv3/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/conv3/biases/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 384
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassner/conv3/biases"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 384
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassner/conv3/biases/Assign"
  op: "Assign"
  input: "LeviHassner/conv3/biases"
  input: "LeviHassner/conv3/biases/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassner/conv3/biases/read"
  op: "Identity"
  input: "LeviHassner/conv3/biases"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/biases"
      }
    }
  }
}
node {
  name: "LeviHassner/conv3/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\000\001\000\000\200\001\000\000"
      }
    }
  }
}
node {
  name: "LeviHassner/conv3/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "LeviHassner/conv3/convolution"
  op: "Conv2D"
  input: "LeviHassner/norm2"
  input: "LeviHassner/conv3/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassner/conv3/BiasAdd"
  op: "BiasAdd"
  input: "LeviHassner/conv3/convolution"
  input: "LeviHassner/conv3/biases/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "LeviHassner/conv3/Relu"
  op: "Relu"
  input: "LeviHassner/conv3/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassner/pool3/MaxPool"
  op: "MaxPool"
  input: "LeviHassner/conv3/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 3
        i: 3
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "LeviHassner/reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\377\377\377\377\0006\000\000"
      }
    }
  }
}
node {
  name: "LeviHassner/reshape"
  op: "Reshape"
  input: "LeviHassner/pool3/MaxPool"
  input: "LeviHassner/reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "LeviHassner/full1/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\0006\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "LeviHassner/full1/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassner/full1/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00499999988824
      }
    }
  }
}
node {
  name: "LeviHassner/full1/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "LeviHassner/full1/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "LeviHassner/full1/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "LeviHassner/full1/weights/Initializer/random_normal/RandomStandardNormal"
  input: "LeviHassner/full1/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/full1/weights/Initializer/random_normal"
  op: "Add"
  input: "LeviHassner/full1/weights/Initializer/random_normal/mul"
  input: "LeviHassner/full1/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/full1/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 13824
        }
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassner/full1/weights/Assign"
  op: "Assign"
  input: "LeviHassner/full1/weights"
  input: "LeviHassner/full1/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassner/full1/weights/read"
  op: "Identity"
  input: "LeviHassner/full1/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/full1/kernel/Regularizer/l2_regularizer/scale"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.000500000023749
      }
    }
  }
}
node {
  name: "LeviHassner/full1/kernel/Regularizer/l2_regularizer/L2Loss"
  op: "L2Loss"
  input: "LeviHassner/full1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/full1/kernel/Regularizer/l2_regularizer"
  op: "Mul"
  input: "LeviHassner/full1/kernel/Regularizer/l2_regularizer/scale"
  input: "LeviHassner/full1/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/full1/biases/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassner/full1/biases"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassner/full1/biases/Assign"
  op: "Assign"
  input: "LeviHassner/full1/biases"
  input: "LeviHassner/full1/biases/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassner/full1/biases/read"
  op: "Identity"
  input: "LeviHassner/full1/biases"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/biases"
      }
    }
  }
}
node {
  name: "LeviHassner/full1/MatMul"
  op: "MatMul"
  input: "LeviHassner/reshape"
  input: "LeviHassner/full1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "LeviHassner/full1/BiasAdd"
  op: "BiasAdd"
  input: "LeviHassner/full1/MatMul"
  input: "LeviHassner/full1/biases/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "LeviHassner/full1/Relu"
  op: "Relu"
  input: "LeviHassner/full1/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassner/drop1/keep_prob"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassner/full2/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\002\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "LeviHassner/full2/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassner/full2/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00499999988824
      }
    }
  }
}
node {
  name: "LeviHassner/full2/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "LeviHassner/full2/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "LeviHassner/full2/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "LeviHassner/full2/weights/Initializer/random_normal/RandomStandardNormal"
  input: "LeviHassner/full2/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/full2/weights/Initializer/random_normal"
  op: "Add"
  input: "LeviHassner/full2/weights/Initializer/random_normal/mul"
  input: "LeviHassner/full2/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/full2/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassner/full2/weights/Assign"
  op: "Assign"
  input: "LeviHassner/full2/weights"
  input: "LeviHassner/full2/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassner/full2/weights/read"
  op: "Identity"
  input: "LeviHassner/full2/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/full2/kernel/Regularizer/l2_regularizer/scale"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.000500000023749
      }
    }
  }
}
node {
  name: "LeviHassner/full2/kernel/Regularizer/l2_regularizer/L2Loss"
  op: "L2Loss"
  input: "LeviHassner/full2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/full2/kernel/Regularizer/l2_regularizer"
  op: "Mul"
  input: "LeviHassner/full2/kernel/Regularizer/l2_regularizer/scale"
  input: "LeviHassner/full2/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
}
node {
  name: "LeviHassner/full2/biases/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassner/full2/biases"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassner/full2/biases/Assign"
  op: "Assign"
  input: "LeviHassner/full2/biases"
  input: "LeviHassner/full2/biases/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassner/full2/biases/read"
  op: "Identity"
  input: "LeviHassner/full2/biases"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/biases"
      }
    }
  }
}
node {
  name: "LeviHassner/full2/MatMul"
  op: "MatMul"
  input: "LeviHassner/full1/Relu"
  input: "LeviHassner/full2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "LeviHassner/full2/BiasAdd"
  op: "BiasAdd"
  input: "LeviHassner/full2/MatMul"
  input: "LeviHassner/full2/biases/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "LeviHassner/full2/Relu"
  op: "Relu"
  input: "LeviHassner/full2/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassner/drop2/keep_prob"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "output/random_normal/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\002\000\000\010\000\000\000"
      }
    }
  }
}
node {
  name: "output/random_normal/mean"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "output/random_normal/stddev"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "output/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "output/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "output/random_normal/mul"
  op: "Mul"
  input: "output/random_normal/RandomStandardNormal"
  input: "output/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "output/random_normal"
  op: "Add"
  input: "output/random_normal/mul"
  input: "output/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "output/weights"
  op: "VariableV2"
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
        dim {
          size: 8
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "output/weights/Assign"
  op: "Assign"
  input: "output/weights"
  input: "output/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "output/weights/read"
  op: "Identity"
  input: "output/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
}
node {
  name: "output/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 8
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "output/biases"
  op: "VariableV2"
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 8
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "output/biases/Assign"
  op: "Assign"
  input: "output/biases"
  input: "output/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "output/biases/read"
  op: "Identity"
  input: "output/biases"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
}
node {
  name: "output/MatMul"
  op: "MatMul"
  input: "LeviHassner/full2/Relu"
  input: "output/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "output/output"
  op: "Add"
  input: "output/MatMul"
  input: "output/biases/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "cross_entropy_per_example/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 128
      }
    }
  }
}
node {
  name: "cross_entropy_per_example/cross_entropy_per_example"
  op: "SparseSoftmaxCrossEntropyWithLogits"
  input: "output/output"
  input: "batch_processing/Reshape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tlabels"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "cross_entropy"
  op: "Mean"
  input: "cross_entropy_per_example/cross_entropy_per_example"
  input: "Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "add/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "add"
  op: "Add"
  input: "add/x"
  input: "LeviHassner/conv1/kernel/Regularizer/l2_regularizer"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_1"
  op: "Add"
  input: "add"
  input: "LeviHassner/conv2/kernel/Regularizer/l2_regularizer"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_2"
  op: "Add"
  input: "add_1"
  input: "LeviHassner/conv3/kernel/Regularizer/l2_regularizer"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_3"
  op: "Add"
  input: "add_2"
  input: "LeviHassner/full1/kernel/Regularizer/l2_regularizer"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_4"
  op: "Add"
  input: "add_3"
  input: "LeviHassner/full2/kernel/Regularizer/l2_regularizer"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "mul"
  op: "Mul"
  input: "mul/x"
  input: "add_4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_5"
  op: "Add"
  input: "cross_entropy"
  input: "mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "tl__raw_/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "tl__raw_"
      }
    }
  }
}
node {
  name: "tl__raw_"
  op: "ScalarSummary"
  input: "tl__raw_/tags"
  input: "add_5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "cross_entropy/avg/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "cross_entropy/avg"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "cross_entropy/avg/Assign"
  op: "Assign"
  input: "cross_entropy/avg"
  input: "cross_entropy/avg/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "cross_entropy/avg/read"
  op: "Identity"
  input: "cross_entropy/avg"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
}
node {
  name: "add_5/avg/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "add_5/avg"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "add_5/avg/Assign"
  op: "Assign"
  input: "add_5/avg"
  input: "add_5/avg/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "add_5/avg/read"
  op: "Identity"
  input: "add_5/avg"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
}
node {
  name: "avg/decay"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.899999976158
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg/sub/x"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg/sub"
  op: "Sub"
  input: "avg/AssignMovingAvg/sub/x"
  input: "avg/decay"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg/sub_1"
  op: "Sub"
  input: "cross_entropy/avg/read"
  input: "cross_entropy"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg/mul"
  op: "Mul"
  input: "avg/AssignMovingAvg/sub_1"
  input: "avg/AssignMovingAvg/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg"
  op: "AssignSub"
  input: "cross_entropy/avg"
  input: "avg/AssignMovingAvg/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "avg/AssignMovingAvg_1/sub/x"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg_1/sub"
  op: "Sub"
  input: "avg/AssignMovingAvg_1/sub/x"
  input: "avg/decay"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg_1/sub_1"
  op: "Sub"
  input: "add_5/avg/read"
  input: "add_5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg_1/mul"
  op: "Mul"
  input: "avg/AssignMovingAvg_1/sub_1"
  input: "avg/AssignMovingAvg_1/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg_1"
  op: "AssignSub"
  input: "add_5/avg"
  input: "avg/AssignMovingAvg_1/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "avg"
  op: "NoOp"
  input: "^avg/AssignMovingAvg"
  input: "^avg/AssignMovingAvg_1"
}
node {
  name: "cross_entropy__raw_/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "cross_entropy__raw_"
      }
    }
  }
}
node {
  name: "cross_entropy__raw_"
  op: "ScalarSummary"
  input: "cross_entropy__raw_/tags"
  input: "cross_entropy"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "cross_entropy_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "cross_entropy_1"
      }
    }
  }
}
node {
  name: "cross_entropy_1"
  op: "ScalarSummary"
  input: "cross_entropy_1/tags"
  input: "cross_entropy/avg/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_5__raw_/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "add_5__raw_"
      }
    }
  }
}
node {
  name: "add_5__raw_"
  op: "ScalarSummary"
  input: "add_5__raw_/tags"
  input: "add_5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_5_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "add_5_1"
      }
    }
  }
}
node {
  name: "add_5_1"
  op: "ScalarSummary"
  input: "add_5_1/tags"
  input: "add_5/avg/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "Identity"
  op: "Identity"
  input: "add_5"
  input: "^avg"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "Variable/initial_value"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "Variable"
  op: "VariableV2"
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "Variable/Assign"
  op: "Assign"
  input: "Variable"
  input: "Variable/initial_value"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "Variable/read"
  op: "Identity"
  input: "Variable"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@Variable"
      }
    }
  }
}
node {
  name: "OptimizeLoss/learning_rate/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/learning_rate"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "OptimizeLoss/learning_rate"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/learning_rate"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/learning_rate/Assign"
  op: "Assign"
  input: "OptimizeLoss/learning_rate"
  input: "OptimizeLoss/learning_rate/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/learning_rate"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/learning_rate/read"
  op: "Identity"
  input: "OptimizeLoss/learning_rate"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/learning_rate"
      }
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/Cast"
  op: "Cast"
  input: "Variable/read"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/Cast_1/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 10000
      }
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/Cast_1"
  op: "Cast"
  input: "OptimizeLoss/ExponentialDecay/Cast_1/x"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/Cast_2/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.10000000149
      }
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/truediv"
  op: "RealDiv"
  input: "OptimizeLoss/ExponentialDecay/Cast"
  input: "OptimizeLoss/ExponentialDecay/Cast_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/Floor"
  op: "Floor"
  input: "OptimizeLoss/ExponentialDecay/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/Pow"
  op: "Pow"
  input: "OptimizeLoss/ExponentialDecay/Cast_2/x"
  input: "OptimizeLoss/ExponentialDecay/Floor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay"
  op: "Mul"
  input: "OptimizeLoss/learning_rate/read"
  input: "OptimizeLoss/ExponentialDecay/Pow"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/learning_rate_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "OptimizeLoss/learning_rate_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/learning_rate_1"
  op: "ScalarSummary"
  input: "OptimizeLoss/learning_rate_1/tags"
  input: "OptimizeLoss/ExponentialDecay"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/Fill"
  op: "Fill"
  input: "OptimizeLoss/gradients/Shape"
  input: "OptimizeLoss/gradients/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_5_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_5_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_5_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/add_5_grad/Shape"
  input: "OptimizeLoss/gradients/add_5_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_5_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/Fill"
  input: "OptimizeLoss/gradients/add_5_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_5_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_5_grad/Sum"
  input: "OptimizeLoss/gradients/add_5_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_5_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/Fill"
  input: "OptimizeLoss/gradients/add_5_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_5_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_5_grad/Sum_1"
  input: "OptimizeLoss/gradients/add_5_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_5_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/add_5_grad/Reshape"
  input: "^OptimizeLoss/gradients/add_5_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/add_5_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_5_grad/Reshape"
  input: "^OptimizeLoss/gradients/add_5_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/add_5_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_5_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_5_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/add_5_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/add_5_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_5_grad/tuple/control_dependency"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Tile/multiples"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 128
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Tile"
  op: "Tile"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Reshape"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Tile/multiples"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tmultiples"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 128
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Prod"
  op: "Prod"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Shape"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Prod_1"
  op: "Prod"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Shape_1"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Const_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Maximum/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Maximum"
  op: "Maximum"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Prod_1"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Maximum/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/floordiv"
  op: "FloorDiv"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Prod"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Maximum"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Cast"
  op: "Cast"
  input: "OptimizeLoss/gradients/cross_entropy_grad/floordiv"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/truediv"
  op: "RealDiv"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Tile"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Cast"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/mul_grad/Shape"
  input: "OptimizeLoss/gradients/mul_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_5_grad/tuple/control_dependency_1"
  input: "add_4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/mul_grad/mul"
  input: "OptimizeLoss/gradients/mul_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/mul_grad/Sum"
  input: "OptimizeLoss/gradients/mul_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/mul_1"
  op: "Mul"
  input: "mul/x"
  input: "OptimizeLoss/gradients/add_5_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/mul_grad/mul_1"
  input: "OptimizeLoss/gradients/mul_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/mul_grad/Sum_1"
  input: "OptimizeLoss/gradients/mul_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/mul_grad/Reshape"
  input: "^OptimizeLoss/gradients/mul_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/mul_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/mul_grad/Reshape"
  input: "^OptimizeLoss/gradients/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/mul_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 128
          }
          dim {
            size: 8
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/PreventGradient"
  op: "PreventGradient"
  input: "cross_entropy_per_example/cross_entropy_per_example:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "message"
    value {
      s: "Currently there is no way to take the second derivative of sparse_softmax_cross_entropy_with_logits due to the fused implementation\'s interaction with tf.gradients()"
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: -1
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/ExpandDims"
  op: "ExpandDims"
  input: "OptimizeLoss/gradients/cross_entropy_grad/truediv"
  input: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/ExpandDims"
  input: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/PreventGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_4_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_4_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_4_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/add_4_grad/Shape"
  input: "OptimizeLoss/gradients/add_4_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_4_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/mul_grad/tuple/control_dependency_1"
  input: "OptimizeLoss/gradients/add_4_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_4_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_4_grad/Sum"
  input: "OptimizeLoss/gradients/add_4_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_4_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/mul_grad/tuple/control_dependency_1"
  input: "OptimizeLoss/gradients/add_4_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_4_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_4_grad/Sum_1"
  input: "OptimizeLoss/gradients/add_4_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_4_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/add_4_grad/Reshape"
  input: "^OptimizeLoss/gradients/add_4_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/add_4_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_4_grad/Reshape"
  input: "^OptimizeLoss/gradients/add_4_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/add_4_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_4_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_4_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/add_4_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/add_4_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\200\000\000\000\010\000\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 8
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/output/output_grad/Shape"
  input: "OptimizeLoss/gradients/output/output_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/mul"
  input: "OptimizeLoss/gradients/output/output_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/output/output_grad/Sum"
  input: "OptimizeLoss/gradients/output/output_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/mul"
  input: "OptimizeLoss/gradients/output/output_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/output/output_grad/Sum_1"
  input: "OptimizeLoss/gradients/output/output_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/output/output_grad/Reshape"
  input: "^OptimizeLoss/gradients/output/output_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/output/output_grad/Reshape"
  input: "^OptimizeLoss/gradients/output/output_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/output_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/output/output_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/output/output_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/output_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_3_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_3_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_3_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/add_3_grad/Shape"
  input: "OptimizeLoss/gradients/add_3_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_3_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/add_4_grad/tuple/control_dependency"
  input: "OptimizeLoss/gradients/add_3_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_3_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_3_grad/Sum"
  input: "OptimizeLoss/gradients/add_3_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_3_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/add_4_grad/tuple/control_dependency"
  input: "OptimizeLoss/gradients/add_3_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_3_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_3_grad/Sum_1"
  input: "OptimizeLoss/gradients/add_3_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_3_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/add_3_grad/Reshape"
  input: "^OptimizeLoss/gradients/add_3_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/add_3_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_3_grad/Reshape"
  input: "^OptimizeLoss/gradients/add_3_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/add_3_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_3_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_3_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/add_3_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/add_3_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Shape"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_4_grad/tuple/control_dependency_1"
  input: "LeviHassner/full2/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Sum"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/mul_1"
  op: "Mul"
  input: "LeviHassner/full2/kernel/Regularizer/l2_regularizer/scale"
  input: "OptimizeLoss/gradients/add_4_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/mul_1"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Sum_1"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Reshape"
  input: "^OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Reshape"
  input: "^OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/MatMul_grad/MatMul"
  op: "MatMul"
  input: "OptimizeLoss/gradients/output/output_grad/tuple/control_dependency"
  input: "output/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
  op: "MatMul"
  input: "LeviHassner/full2/Relu"
  input: "OptimizeLoss/gradients/output/output_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: true
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/MatMul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/output/MatMul_grad/MatMul"
  input: "^OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
}
node {
  name: "OptimizeLoss/gradients/output/MatMul_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/output/MatMul_grad/MatMul"
  input: "^OptimizeLoss/gradients/output/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/MatMul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
  input: "^OptimizeLoss/gradients/output/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_2_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_2_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_2_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/add_2_grad/Shape"
  input: "OptimizeLoss/gradients/add_2_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_2_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/add_3_grad/tuple/control_dependency"
  input: "OptimizeLoss/gradients/add_2_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_2_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_2_grad/Sum"
  input: "OptimizeLoss/gradients/add_2_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_2_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/add_3_grad/tuple/control_dependency"
  input: "OptimizeLoss/gradients/add_2_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_2_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_2_grad/Sum_1"
  input: "OptimizeLoss/gradients/add_2_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_2_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/add_2_grad/Reshape"
  input: "^OptimizeLoss/gradients/add_2_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/add_2_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_2_grad/Reshape"
  input: "^OptimizeLoss/gradients/add_2_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/add_2_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_2_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_2_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/add_2_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/add_2_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Shape"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_3_grad/tuple/control_dependency_1"
  input: "LeviHassner/full1/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Sum"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/mul_1"
  op: "Mul"
  input: "LeviHassner/full1/kernel/Regularizer/l2_regularizer/scale"
  input: "OptimizeLoss/gradients/add_3_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/mul_1"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Sum_1"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Reshape"
  input: "^OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Reshape"
  input: "^OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  op: "Mul"
  input: "LeviHassner/full2/weights/read"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "OptimizeLoss/gradients/output/MatMul_grad/tuple/control_dependency"
  input: "LeviHassner/full2/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_1_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_1_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_1_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/add_1_grad/Shape"
  input: "OptimizeLoss/gradients/add_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_1_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/add_2_grad/tuple/control_dependency"
  input: "OptimizeLoss/gradients/add_1_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_1_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_1_grad/Sum"
  input: "OptimizeLoss/gradients/add_1_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_1_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/add_2_grad/tuple/control_dependency"
  input: "OptimizeLoss/gradients/add_1_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_1_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_1_grad/Sum_1"
  input: "OptimizeLoss/gradients/add_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_1_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/add_1_grad/Reshape"
  input: "^OptimizeLoss/gradients/add_1_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/add_1_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_1_grad/Reshape"
  input: "^OptimizeLoss/gradients/add_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/add_1_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_1_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_1_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/add_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/add_1_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Shape"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_2_grad/tuple/control_dependency_1"
  input: "LeviHassner/conv3/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Sum"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/mul_1"
  op: "Mul"
  input: "LeviHassner/conv3/kernel/Regularizer/l2_regularizer/scale"
  input: "OptimizeLoss/gradients/add_2_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/mul_1"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Sum_1"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Reshape"
  input: "^OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Reshape"
  input: "^OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  op: "Mul"
  input: "LeviHassner/full1/weights/read"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "OptimizeLoss/gradients/LeviHassner/full2/Relu_grad/ReluGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/full2/Relu_grad/ReluGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/BiasAddGrad"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/full2/Relu_grad/ReluGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full2/Relu_grad/ReluGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/BiasAddGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/add_grad/Shape"
  input: "OptimizeLoss/gradients/add_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/add_1_grad/tuple/control_dependency"
  input: "OptimizeLoss/gradients/add_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_grad/Sum"
  input: "OptimizeLoss/gradients/add_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/add_1_grad/tuple/control_dependency"
  input: "OptimizeLoss/gradients/add_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_grad/Sum_1"
  input: "OptimizeLoss/gradients/add_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/add_grad/Reshape"
  input: "^OptimizeLoss/gradients/add_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/add_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_grad/Reshape"
  input: "^OptimizeLoss/gradients/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/add_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/add_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Shape"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_1_grad/tuple/control_dependency_1"
  input: "LeviHassner/conv2/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Sum"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/mul_1"
  op: "Mul"
  input: "LeviHassner/conv2/kernel/Regularizer/l2_regularizer/scale"
  input: "OptimizeLoss/gradients/add_1_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/mul_1"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Sum_1"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Reshape"
  input: "^OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Reshape"
  input: "^OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  op: "Mul"
  input: "LeviHassner/conv3/weights/read"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/MatMul"
  op: "MatMul"
  input: "OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/tuple/control_dependency"
  input: "LeviHassner/full2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/MatMul_1"
  op: "MatMul"
  input: "LeviHassner/full1/Relu"
  input: "OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: true
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/MatMul"
  input: "^OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/MatMul_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/MatMul"
  input: "^OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/MatMul_1"
  input: "^OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Shape"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_grad/tuple/control_dependency_1"
  input: "LeviHassner/conv1/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Sum"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/mul_1"
  op: "Mul"
  input: "LeviHassner/conv1/kernel/Regularizer/l2_regularizer/scale"
  input: "OptimizeLoss/gradients/add_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/mul_1"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Sum_1"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Reshape"
  input: "^OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Reshape"
  input: "^OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  op: "Mul"
  input: "LeviHassner/conv2/weights/read"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/tuple/control_dependency"
  input: "LeviHassner/full1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/AddN"
  op: "AddN"
  input: "OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassner/full2/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  op: "Mul"
  input: "LeviHassner/conv1/weights/read"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "OptimizeLoss/gradients/LeviHassner/full1/Relu_grad/ReluGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/full1/Relu_grad/ReluGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/BiasAddGrad"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/full1/Relu_grad/ReluGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full1/Relu_grad/ReluGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/BiasAddGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/MatMul"
  op: "MatMul"
  input: "OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/tuple/control_dependency"
  input: "LeviHassner/full1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/MatMul_1"
  op: "MatMul"
  input: "LeviHassner/reshape"
  input: "OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: true
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/MatMul"
  input: "^OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/MatMul_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/MatMul"
  input: "^OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/MatMul_1"
  input: "^OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/reshape_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\200\000\000\000\006\000\000\000\006\000\000\000\200\001\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/reshape_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/tuple/control_dependency"
  input: "OptimizeLoss/gradients/LeviHassner/reshape_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/AddN_1"
  op: "AddN"
  input: "OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassner/full1/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/pool3/MaxPool_grad/MaxPoolGrad"
  op: "MaxPoolGrad"
  input: "LeviHassner/conv3/Relu"
  input: "LeviHassner/pool3/MaxPool"
  input: "OptimizeLoss/gradients/LeviHassner/reshape_grad/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 3
        i: 3
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "OptimizeLoss/gradients/LeviHassner/pool3/MaxPool_grad/MaxPoolGrad"
  input: "LeviHassner/conv3/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/Relu_grad/ReluGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/conv3/Relu_grad/ReluGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/BiasAddGrad"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/Relu_grad/ReluGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv3/Relu_grad/ReluGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/BiasAddGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\200\000\000\000\r\000\000\000\r\000\000\000\000\001\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/Conv2DBackpropInput"
  op: "Conv2DBackpropInput"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/Shape"
  input: "LeviHassner/conv3/weights/read"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\000\001\000\000\200\001\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/Conv2DBackpropFilter"
  op: "Conv2DBackpropFilter"
  input: "LeviHassner/norm2"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/Shape_1"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/Conv2DBackpropInput"
  input: "^OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/Conv2DBackpropFilter"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/Conv2DBackpropInput"
  input: "^OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/Conv2DBackpropInput"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/Conv2DBackpropFilter"
  input: "^OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/Conv2DBackpropFilter"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/norm2_grad/LRNGrad"
  op: "LRNGrad"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/tuple/control_dependency"
  input: "LeviHassner/pool2/MaxPool"
  input: "LeviHassner/norm2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "alpha"
    value {
      f: 9.99999974738e-05
    }
  }
  attr {
    key: "beta"
    value {
      f: 0.75
    }
  }
  attr {
    key: "bias"
    value {
      f: 1.0
    }
  }
  attr {
    key: "depth_radius"
    value {
      i: 5
    }
  }
}
node {
  name: "OptimizeLoss/gradients/AddN_2"
  op: "AddN"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/convolution_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/pool2/MaxPool_grad/MaxPoolGrad"
  op: "MaxPoolGrad"
  input: "LeviHassner/conv2/Relu"
  input: "LeviHassner/pool2/MaxPool"
  input: "OptimizeLoss/gradients/LeviHassner/norm2_grad/LRNGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 3
        i: 3
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "OptimizeLoss/gradients/LeviHassner/pool2/MaxPool_grad/MaxPoolGrad"
  input: "LeviHassner/conv2/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/Relu_grad/ReluGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/conv2/Relu_grad/ReluGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/BiasAddGrad"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/Relu_grad/ReluGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv2/Relu_grad/ReluGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/BiasAddGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\200\000\000\000\033\000\000\000\033\000\000\000`\000\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/Conv2DBackpropInput"
  op: "Conv2DBackpropInput"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/Shape"
  input: "LeviHassner/conv2/weights/read"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\005\000\000\000\005\000\000\000`\000\000\000\000\001\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/Conv2DBackpropFilter"
  op: "Conv2DBackpropFilter"
  input: "LeviHassner/norm1"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/Shape_1"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/Conv2DBackpropInput"
  input: "^OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/Conv2DBackpropFilter"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/Conv2DBackpropInput"
  input: "^OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/Conv2DBackpropInput"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/Conv2DBackpropFilter"
  input: "^OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/Conv2DBackpropFilter"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/norm1_grad/LRNGrad"
  op: "LRNGrad"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/tuple/control_dependency"
  input: "LeviHassner/pool1/MaxPool"
  input: "LeviHassner/norm1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "alpha"
    value {
      f: 9.99999974738e-05
    }
  }
  attr {
    key: "beta"
    value {
      f: 0.75
    }
  }
  attr {
    key: "bias"
    value {
      f: 1.0
    }
  }
  attr {
    key: "depth_radius"
    value {
      i: 5
    }
  }
}
node {
  name: "OptimizeLoss/gradients/AddN_3"
  op: "AddN"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/convolution_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/pool1/MaxPool_grad/MaxPoolGrad"
  op: "MaxPoolGrad"
  input: "LeviHassner/conv1/Relu"
  input: "LeviHassner/pool1/MaxPool"
  input: "OptimizeLoss/gradients/LeviHassner/norm1_grad/LRNGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 3
        i: 3
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "OptimizeLoss/gradients/LeviHassner/pool1/MaxPool_grad/MaxPoolGrad"
  input: "LeviHassner/conv1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/Relu_grad/ReluGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/conv1/Relu_grad/ReluGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/BiasAddGrad"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/Relu_grad/ReluGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv1/Relu_grad/ReluGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/BiasAddGrad"
  input: "^OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\200\000\000\000\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/Conv2DBackpropInput"
  op: "Conv2DBackpropInput"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/Shape"
  input: "LeviHassner/conv1/weights/read"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 4
        i: 4
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\007\000\000\000\007\000\000\000\003\000\000\000`\000\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/Conv2DBackpropFilter"
  op: "Conv2DBackpropFilter"
  input: "batch_processing/Reshape"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/Shape_1"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 4
        i: 4
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/Conv2DBackpropInput"
  input: "^OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/Conv2DBackpropFilter"
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/Conv2DBackpropInput"
  input: "^OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/Conv2DBackpropInput"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/Conv2DBackpropFilter"
  input: "^OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/Conv2DBackpropFilter"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/AddN_4"
  op: "AddN"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/convolution_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN_4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_1"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_2"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_3"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_4"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_5"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_6"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_7"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_8"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_9"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_10"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/output/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_11"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/output/output_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/output_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/stack"
  op: "Pack"
  input: "OptimizeLoss/global_norm/L2Loss"
  input: "OptimizeLoss/global_norm/L2Loss_1"
  input: "OptimizeLoss/global_norm/L2Loss_2"
  input: "OptimizeLoss/global_norm/L2Loss_3"
  input: "OptimizeLoss/global_norm/L2Loss_4"
  input: "OptimizeLoss/global_norm/L2Loss_5"
  input: "OptimizeLoss/global_norm/L2Loss_6"
  input: "OptimizeLoss/global_norm/L2Loss_7"
  input: "OptimizeLoss/global_norm/L2Loss_8"
  input: "OptimizeLoss/global_norm/L2Loss_9"
  input: "OptimizeLoss/global_norm/L2Loss_10"
  input: "OptimizeLoss/global_norm/L2Loss_11"
  attr {
    key: "N"
    value {
      i: 12
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/Sum"
  op: "Sum"
  input: "OptimizeLoss/global_norm/stack"
  input: "OptimizeLoss/global_norm/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/mul"
  op: "Mul"
  input: "OptimizeLoss/global_norm/Sum"
  input: "OptimizeLoss/global_norm/Const_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/global_norm"
  op: "Sqrt"
  input: "OptimizeLoss/global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/truediv/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/truediv"
  op: "RealDiv"
  input: "OptimizeLoss/clip_by_global_norm/truediv/x"
  input: "OptimizeLoss/global_norm/global_norm"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/truediv_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 4.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/truediv_1"
  op: "RealDiv"
  input: "OptimizeLoss/clip_by_global_norm/Const"
  input: "OptimizeLoss/clip_by_global_norm/truediv_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/Minimum"
  op: "Minimum"
  input: "OptimizeLoss/clip_by_global_norm/truediv"
  input: "OptimizeLoss/clip_by_global_norm/truediv_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 4.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul"
  op: "Mul"
  input: "OptimizeLoss/clip_by_global_norm/mul/x"
  input: "OptimizeLoss/clip_by_global_norm/Minimum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_1"
  op: "Mul"
  input: "OptimizeLoss/gradients/AddN_4"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_0"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_2"
  op: "Mul"
  input: "OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/tuple/control_dependency_1"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_1"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_3"
  op: "Mul"
  input: "OptimizeLoss/gradients/AddN_3"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_2"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_4"
  op: "Mul"
  input: "OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/tuple/control_dependency_1"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_3"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_5"
  op: "Mul"
  input: "OptimizeLoss/gradients/AddN_2"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_4"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_6"
  op: "Mul"
  input: "OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/tuple/control_dependency_1"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_5"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_6"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/conv3/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_7"
  op: "Mul"
  input: "OptimizeLoss/gradients/AddN_1"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_6"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_7"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_8"
  op: "Mul"
  input: "OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/tuple/control_dependency_1"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_7"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_8"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_9"
  op: "Mul"
  input: "OptimizeLoss/gradients/AddN"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_8"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_9"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_10"
  op: "Mul"
  input: "OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/tuple/control_dependency_1"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_9"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_10"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassner/full2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_11"
  op: "Mul"
  input: "OptimizeLoss/gradients/output/MatMul_grad/tuple/control_dependency_1"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_10"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_11"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_12"
  op: "Mul"
  input: "OptimizeLoss/gradients/output/output_grad/tuple/control_dependency_1"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/output_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_11"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_12"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/output_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/loss/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "OptimizeLoss/loss"
      }
    }
  }
}
node {
  name: "OptimizeLoss/loss"
  op: "ScalarSummary"
  input: "OptimizeLoss/loss/tags"
  input: "Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv1/weights/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 7
          }
          dim {
            size: 7
          }
          dim {
            size: 3
          }
          dim {
            size: 96
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv1/weights/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 7
        }
        dim {
          size: 7
        }
        dim {
          size: 3
        }
        dim {
          size: 96
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv1/weights/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/conv1/weights/Momentum"
  input: "OptimizeLoss/LeviHassner/conv1/weights/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv1/weights/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassner/conv1/weights/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv1/biases/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 96
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv1/biases/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 96
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv1/biases/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/conv1/biases/Momentum"
  input: "OptimizeLoss/LeviHassner/conv1/biases/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv1/biases/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassner/conv1/biases/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/biases"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv2/weights/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 5
          }
          dim {
            size: 5
          }
          dim {
            size: 96
          }
          dim {
            size: 256
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv2/weights/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 5
        }
        dim {
          size: 5
        }
        dim {
          size: 96
        }
        dim {
          size: 256
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv2/weights/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/conv2/weights/Momentum"
  input: "OptimizeLoss/LeviHassner/conv2/weights/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv2/weights/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassner/conv2/weights/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv2/biases/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 256
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv2/biases/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 256
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv2/biases/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/conv2/biases/Momentum"
  input: "OptimizeLoss/LeviHassner/conv2/biases/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv2/biases/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassner/conv2/biases/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/biases"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv3/weights/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 3
          }
          dim {
            size: 3
          }
          dim {
            size: 256
          }
          dim {
            size: 384
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv3/weights/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 256
        }
        dim {
          size: 384
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv3/weights/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/conv3/weights/Momentum"
  input: "OptimizeLoss/LeviHassner/conv3/weights/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv3/weights/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassner/conv3/weights/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv3/biases/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 384
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv3/biases/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 384
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv3/biases/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/conv3/biases/Momentum"
  input: "OptimizeLoss/LeviHassner/conv3/biases/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/conv3/biases/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassner/conv3/biases/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/biases"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full1/weights/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 13824
          }
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full1/weights/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 13824
        }
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full1/weights/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/full1/weights/Momentum"
  input: "OptimizeLoss/LeviHassner/full1/weights/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full1/weights/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassner/full1/weights/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full1/biases/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full1/biases/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full1/biases/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/full1/biases/Momentum"
  input: "OptimizeLoss/LeviHassner/full1/biases/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full1/biases/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassner/full1/biases/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/biases"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full2/weights/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full2/weights/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full2/weights/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/full2/weights/Momentum"
  input: "OptimizeLoss/LeviHassner/full2/weights/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full2/weights/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassner/full2/weights/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full2/biases/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full2/biases/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full2/biases/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/full2/biases/Momentum"
  input: "OptimizeLoss/LeviHassner/full2/biases/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassner/full2/biases/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassner/full2/biases/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/biases"
      }
    }
  }
}
node {
  name: "OptimizeLoss/output/weights/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
          dim {
            size: 8
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/output/weights/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
        dim {
          size: 8
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/output/weights/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/output/weights/Momentum"
  input: "OptimizeLoss/output/weights/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/output/weights/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/output/weights/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
}
node {
  name: "OptimizeLoss/output/biases/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 8
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/output/biases/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 8
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/output/biases/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/output/biases/Momentum"
  input: "OptimizeLoss/output/biases/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/output/biases/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/output/biases/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
}
node {
  name: "OptimizeLoss/train/momentum"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.899999976158
      }
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassner/conv1/weights/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassner/conv1/weights"
  input: "OptimizeLoss/LeviHassner/conv1/weights/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_0"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassner/conv1/biases/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassner/conv1/biases"
  input: "OptimizeLoss/LeviHassner/conv1/biases/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_1"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassner/conv2/weights/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassner/conv2/weights"
  input: "OptimizeLoss/LeviHassner/conv2/weights/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_2"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassner/conv2/biases/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassner/conv2/biases"
  input: "OptimizeLoss/LeviHassner/conv2/biases/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_3"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassner/conv3/weights/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassner/conv3/weights"
  input: "OptimizeLoss/LeviHassner/conv3/weights/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_4"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassner/conv3/biases/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassner/conv3/biases"
  input: "OptimizeLoss/LeviHassner/conv3/biases/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_5"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassner/full1/weights/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassner/full1/weights"
  input: "OptimizeLoss/LeviHassner/full1/weights/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_6"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassner/full1/biases/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassner/full1/biases"
  input: "OptimizeLoss/LeviHassner/full1/biases/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_7"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassner/full2/weights/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassner/full2/weights"
  input: "OptimizeLoss/LeviHassner/full2/weights/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_8"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassner/full2/biases/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassner/full2/biases"
  input: "OptimizeLoss/LeviHassner/full2/biases/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_9"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_output/weights/ApplyMomentum"
  op: "ApplyMomentum"
  input: "output/weights"
  input: "OptimizeLoss/output/weights/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_10"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_output/biases/ApplyMomentum"
  op: "ApplyMomentum"
  input: "output/biases"
  input: "OptimizeLoss/output/biases/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_11"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update"
  op: "NoOp"
  input: "^OptimizeLoss/train/update_LeviHassner/conv1/weights/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassner/conv1/biases/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassner/conv2/weights/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassner/conv2/biases/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassner/conv3/weights/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassner/conv3/biases/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassner/full1/weights/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassner/full1/biases/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassner/full2/weights/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassner/full2/biases/ApplyMomentum"
  input: "^OptimizeLoss/train/update_output/weights/ApplyMomentum"
  input: "^OptimizeLoss/train/update_output/biases/ApplyMomentum"
}
node {
  name: "OptimizeLoss/train/value"
  op: "Const"
  input: "^OptimizeLoss/train/update"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@Variable"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "OptimizeLoss/train"
  op: "AssignAdd"
  input: "Variable"
  input: "OptimizeLoss/train/value"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/control_dependency"
  op: "Identity"
  input: "Identity"
  input: "^OptimizeLoss/train"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@Identity"
      }
    }
  }
}
node {
  name: "save/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "model"
      }
    }
  }
}
node {
  name: "save/SaveV2/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 28
          }
        }
        string_val: "LeviHassner/conv1/biases"
        string_val: "LeviHassner/conv1/weights"
        string_val: "LeviHassner/conv2/biases"
        string_val: "LeviHassner/conv2/weights"
        string_val: "LeviHassner/conv3/biases"
        string_val: "LeviHassner/conv3/weights"
        string_val: "LeviHassner/full1/biases"
        string_val: "LeviHassner/full1/weights"
        string_val: "LeviHassner/full2/biases"
        string_val: "LeviHassner/full2/weights"
        string_val: "OptimizeLoss/LeviHassner/conv1/biases/Momentum"
        string_val: "OptimizeLoss/LeviHassner/conv1/weights/Momentum"
        string_val: "OptimizeLoss/LeviHassner/conv2/biases/Momentum"
        string_val: "OptimizeLoss/LeviHassner/conv2/weights/Momentum"
        string_val: "OptimizeLoss/LeviHassner/conv3/biases/Momentum"
        string_val: "OptimizeLoss/LeviHassner/conv3/weights/Momentum"
        string_val: "OptimizeLoss/LeviHassner/full1/biases/Momentum"
        string_val: "OptimizeLoss/LeviHassner/full1/weights/Momentum"
        string_val: "OptimizeLoss/LeviHassner/full2/biases/Momentum"
        string_val: "OptimizeLoss/LeviHassner/full2/weights/Momentum"
        string_val: "OptimizeLoss/learning_rate"
        string_val: "OptimizeLoss/output/biases/Momentum"
        string_val: "OptimizeLoss/output/weights/Momentum"
        string_val: "Variable"
        string_val: "add_5/avg"
        string_val: "cross_entropy/avg"
        string_val: "output/biases"
        string_val: "output/weights"
      }
    }
  }
}
node {
  name: "save/SaveV2/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 28
          }
        }
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
      }
    }
  }
}
node {
  name: "save/SaveV2"
  op: "SaveV2"
  input: "save/Const"
  input: "save/SaveV2/tensor_names"
  input: "save/SaveV2/shape_and_slices"
  input: "LeviHassner/conv1/biases"
  input: "LeviHassner/conv1/weights"
  input: "LeviHassner/conv2/biases"
  input: "LeviHassner/conv2/weights"
  input: "LeviHassner/conv3/biases"
  input: "LeviHassner/conv3/weights"
  input: "LeviHassner/full1/biases"
  input: "LeviHassner/full1/weights"
  input: "LeviHassner/full2/biases"
  input: "LeviHassner/full2/weights"
  input: "OptimizeLoss/LeviHassner/conv1/biases/Momentum"
  input: "OptimizeLoss/LeviHassner/conv1/weights/Momentum"
  input: "OptimizeLoss/LeviHassner/conv2/biases/Momentum"
  input: "OptimizeLoss/LeviHassner/conv2/weights/Momentum"
  input: "OptimizeLoss/LeviHassner/conv3/biases/Momentum"
  input: "OptimizeLoss/LeviHassner/conv3/weights/Momentum"
  input: "OptimizeLoss/LeviHassner/full1/biases/Momentum"
  input: "OptimizeLoss/LeviHassner/full1/weights/Momentum"
  input: "OptimizeLoss/LeviHassner/full2/biases/Momentum"
  input: "OptimizeLoss/LeviHassner/full2/weights/Momentum"
  input: "OptimizeLoss/learning_rate"
  input: "OptimizeLoss/output/biases/Momentum"
  input: "OptimizeLoss/output/weights/Momentum"
  input: "Variable"
  input: "add_5/avg"
  input: "cross_entropy/avg"
  input: "output/biases"
  input: "output/weights"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_INT32
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/control_dependency"
  op: "Identity"
  input: "save/Const"
  input: "^save/SaveV2"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@save/Const"
      }
    }
  }
}
node {
  name: "save/RestoreV2/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "LeviHassner/conv1/biases"
      }
    }
  }
}
node {
  name: "save/RestoreV2/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2/tensor_names"
  input: "save/RestoreV2/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign"
  op: "Assign"
  input: "LeviHassner/conv1/biases"
  input: "save/RestoreV2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_1/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "LeviHassner/conv1/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_1/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_1"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_1/tensor_names"
  input: "save/RestoreV2_1/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_1"
  op: "Assign"
  input: "LeviHassner/conv1/weights"
  input: "save/RestoreV2_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_2/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "LeviHassner/conv2/biases"
      }
    }
  }
}
node {
  name: "save/RestoreV2_2/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_2"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_2/tensor_names"
  input: "save/RestoreV2_2/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_2"
  op: "Assign"
  input: "LeviHassner/conv2/biases"
  input: "save/RestoreV2_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_3/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "LeviHassner/conv2/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_3/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_3"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_3/tensor_names"
  input: "save/RestoreV2_3/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_3"
  op: "Assign"
  input: "LeviHassner/conv2/weights"
  input: "save/RestoreV2_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_4/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "LeviHassner/conv3/biases"
      }
    }
  }
}
node {
  name: "save/RestoreV2_4/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_4"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_4/tensor_names"
  input: "save/RestoreV2_4/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_4"
  op: "Assign"
  input: "LeviHassner/conv3/biases"
  input: "save/RestoreV2_4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_5/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "LeviHassner/conv3/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_5/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_5"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_5/tensor_names"
  input: "save/RestoreV2_5/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_5"
  op: "Assign"
  input: "LeviHassner/conv3/weights"
  input: "save/RestoreV2_5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_6/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "LeviHassner/full1/biases"
      }
    }
  }
}
node {
  name: "save/RestoreV2_6/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_6"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_6/tensor_names"
  input: "save/RestoreV2_6/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_6"
  op: "Assign"
  input: "LeviHassner/full1/biases"
  input: "save/RestoreV2_6"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_7/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "LeviHassner/full1/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_7/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_7"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_7/tensor_names"
  input: "save/RestoreV2_7/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_7"
  op: "Assign"
  input: "LeviHassner/full1/weights"
  input: "save/RestoreV2_7"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_8/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "LeviHassner/full2/biases"
      }
    }
  }
}
node {
  name: "save/RestoreV2_8/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_8"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_8/tensor_names"
  input: "save/RestoreV2_8/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_8"
  op: "Assign"
  input: "LeviHassner/full2/biases"
  input: "save/RestoreV2_8"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_9/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "LeviHassner/full2/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_9/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_9"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_9/tensor_names"
  input: "save/RestoreV2_9/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_9"
  op: "Assign"
  input: "LeviHassner/full2/weights"
  input: "save/RestoreV2_9"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_10/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "OptimizeLoss/LeviHassner/conv1/biases/Momentum"
      }
    }
  }
}
node {
  name: "save/RestoreV2_10/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_10"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_10/tensor_names"
  input: "save/RestoreV2_10/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_10"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/conv1/biases/Momentum"
  input: "save/RestoreV2_10"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_11/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "OptimizeLoss/LeviHassner/conv1/weights/Momentum"
      }
    }
  }
}
node {
  name: "save/RestoreV2_11/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_11"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_11/tensor_names"
  input: "save/RestoreV2_11/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_11"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/conv1/weights/Momentum"
  input: "save/RestoreV2_11"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_12/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "OptimizeLoss/LeviHassner/conv2/biases/Momentum"
      }
    }
  }
}
node {
  name: "save/RestoreV2_12/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_12"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_12/tensor_names"
  input: "save/RestoreV2_12/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_12"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/conv2/biases/Momentum"
  input: "save/RestoreV2_12"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_13/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "OptimizeLoss/LeviHassner/conv2/weights/Momentum"
      }
    }
  }
}
node {
  name: "save/RestoreV2_13/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_13"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_13/tensor_names"
  input: "save/RestoreV2_13/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_13"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/conv2/weights/Momentum"
  input: "save/RestoreV2_13"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_14/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "OptimizeLoss/LeviHassner/conv3/biases/Momentum"
      }
    }
  }
}
node {
  name: "save/RestoreV2_14/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_14"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_14/tensor_names"
  input: "save/RestoreV2_14/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_14"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/conv3/biases/Momentum"
  input: "save/RestoreV2_14"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_15/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "OptimizeLoss/LeviHassner/conv3/weights/Momentum"
      }
    }
  }
}
node {
  name: "save/RestoreV2_15/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_15"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_15/tensor_names"
  input: "save/RestoreV2_15/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_15"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/conv3/weights/Momentum"
  input: "save/RestoreV2_15"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/conv3/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_16/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "OptimizeLoss/LeviHassner/full1/biases/Momentum"
      }
    }
  }
}
node {
  name: "save/RestoreV2_16/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_16"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_16/tensor_names"
  input: "save/RestoreV2_16/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_16"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/full1/biases/Momentum"
  input: "save/RestoreV2_16"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_17/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "OptimizeLoss/LeviHassner/full1/weights/Momentum"
      }
    }
  }
}
node {
  name: "save/RestoreV2_17/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_17"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_17/tensor_names"
  input: "save/RestoreV2_17/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_17"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/full1/weights/Momentum"
  input: "save/RestoreV2_17"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_18/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "OptimizeLoss/LeviHassner/full2/biases/Momentum"
      }
    }
  }
}
node {
  name: "save/RestoreV2_18/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_18"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_18/tensor_names"
  input: "save/RestoreV2_18/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_18"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/full2/biases/Momentum"
  input: "save/RestoreV2_18"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_19/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "OptimizeLoss/LeviHassner/full2/weights/Momentum"
      }
    }
  }
}
node {
  name: "save/RestoreV2_19/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_19"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_19/tensor_names"
  input: "save/RestoreV2_19/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_19"
  op: "Assign"
  input: "OptimizeLoss/LeviHassner/full2/weights/Momentum"
  input: "save/RestoreV2_19"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassner/full2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_20/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "OptimizeLoss/learning_rate"
      }
    }
  }
}
node {
  name: "save/RestoreV2_20/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_20"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_20/tensor_names"
  input: "save/RestoreV2_20/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_20"
  op: "Assign"
  input: "OptimizeLoss/learning_rate"
  input: "save/RestoreV2_20"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/learning_rate"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_21/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "OptimizeLoss/output/biases/Momentum"
      }
    }
  }
}
node {
  name: "save/RestoreV2_21/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_21"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_21/tensor_names"
  input: "save/RestoreV2_21/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_21"
  op: "Assign"
  input: "OptimizeLoss/output/biases/Momentum"
  input: "save/RestoreV2_21"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_22/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "OptimizeLoss/output/weights/Momentum"
      }
    }
  }
}
node {
  name: "save/RestoreV2_22/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_22"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_22/tensor_names"
  input: "save/RestoreV2_22/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_22"
  op: "Assign"
  input: "OptimizeLoss/output/weights/Momentum"
  input: "save/RestoreV2_22"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_23/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "Variable"
      }
    }
  }
}
node {
  name: "save/RestoreV2_23/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_23"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_23/tensor_names"
  input: "save/RestoreV2_23/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_INT32
      }
    }
  }
}
node {
  name: "save/Assign_23"
  op: "Assign"
  input: "Variable"
  input: "save/RestoreV2_23"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_24/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "add_5/avg"
      }
    }
  }
}
node {
  name: "save/RestoreV2_24/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_24"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_24/tensor_names"
  input: "save/RestoreV2_24/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_24"
  op: "Assign"
  input: "add_5/avg"
  input: "save/RestoreV2_24"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_25/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "cross_entropy/avg"
      }
    }
  }
}
node {
  name: "save/RestoreV2_25/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_25"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_25/tensor_names"
  input: "save/RestoreV2_25/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_25"
  op: "Assign"
  input: "cross_entropy/avg"
  input: "save/RestoreV2_25"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_26/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "output/biases"
      }
    }
  }
}
node {
  name: "save/RestoreV2_26/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_26"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_26/tensor_names"
  input: "save/RestoreV2_26/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_26"
  op: "Assign"
  input: "output/biases"
  input: "save/RestoreV2_26"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_27/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "output/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_27/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_27"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_27/tensor_names"
  input: "save/RestoreV2_27/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_27"
  op: "Assign"
  input: "output/weights"
  input: "save/RestoreV2_27"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/restore_all"
  op: "NoOp"
  input: "^save/Assign"
  input: "^save/Assign_1"
  input: "^save/Assign_2"
  input: "^save/Assign_3"
  input: "^save/Assign_4"
  input: "^save/Assign_5"
  input: "^save/Assign_6"
  input: "^save/Assign_7"
  input: "^save/Assign_8"
  input: "^save/Assign_9"
  input: "^save/Assign_10"
  input: "^save/Assign_11"
  input: "^save/Assign_12"
  input: "^save/Assign_13"
  input: "^save/Assign_14"
  input: "^save/Assign_15"
  input: "^save/Assign_16"
  input: "^save/Assign_17"
  input: "^save/Assign_18"
  input: "^save/Assign_19"
  input: "^save/Assign_20"
  input: "^save/Assign_21"
  input: "^save/Assign_22"
  input: "^save/Assign_23"
  input: "^save/Assign_24"
  input: "^save/Assign_25"
  input: "^save/Assign_26"
  input: "^save/Assign_27"
}
node {
  name: "Merge/MergeSummary"
  op: "MergeSummary"
  input: "batch_processing/input_producer/fraction_of_16_full"
  input: "batch_processing/batch_join/fraction_of_1024_full"
  input: "batch_processing/images"
  input: "tl__raw_"
  input: "cross_entropy__raw_"
  input: "cross_entropy_1"
  input: "add_5__raw_"
  input: "add_5_1"
  input: "OptimizeLoss/learning_rate_1"
  input: "OptimizeLoss/loss"
  attr {
    key: "N"
    value {
      i: 10
    }
  }
}
node {
  name: "init"
  op: "NoOp"
  input: "^LeviHassner/conv1/weights/Assign"
  input: "^LeviHassner/conv1/biases/Assign"
  input: "^LeviHassner/conv2/weights/Assign"
  input: "^LeviHassner/conv2/biases/Assign"
  input: "^LeviHassner/conv3/weights/Assign"
  input: "^LeviHassner/conv3/biases/Assign"
  input: "^LeviHassner/full1/weights/Assign"
  input: "^LeviHassner/full1/biases/Assign"
  input: "^LeviHassner/full2/weights/Assign"
  input: "^LeviHassner/full2/biases/Assign"
  input: "^output/weights/Assign"
  input: "^output/biases/Assign"
  input: "^cross_entropy/avg/Assign"
  input: "^add_5/avg/Assign"
  input: "^Variable/Assign"
  input: "^OptimizeLoss/learning_rate/Assign"
  input: "^OptimizeLoss/LeviHassner/conv1/weights/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassner/conv1/biases/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassner/conv2/weights/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassner/conv2/biases/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassner/conv3/weights/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassner/conv3/biases/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassner/full1/weights/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassner/full1/biases/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassner/full2/weights/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassner/full2/biases/Momentum/Assign"
  input: "^OptimizeLoss/output/weights/Momentum/Assign"
  input: "^OptimizeLoss/output/biases/Momentum/Assign"
}
versions {
  producer: 22
}
