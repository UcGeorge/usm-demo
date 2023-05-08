class PriorityQueue<E> {
  final List<_PriorityQueueEntry<E>> _heap;
  final Comparator<E> _comparator;

  int _count = 0;

  PriorityQueue([int Function(E a, E b)? compare])
      : _heap = [],
        _comparator = compare ?? _defaultCompare<E>();

  static int Function(E a, E b) _defaultCompare<E>() {
    return (a, b) => (a as Comparable<E>).compareTo(b);
  }

  void add(E element) {
    _heap.add(_PriorityQueueEntry(_count++, element));
    _siftUp(_heap.length - 1);
  }

  E removeFirst() {
    if (_heap.isEmpty) {
      throw StateError('Priority queue is empty');
    }

    final entry = _heap[0];
    _swap(0, _heap.length - 1);
    _heap.removeLast();
    _siftDown(0);
    return entry.value;
  }

  void _siftUp(int index) {
    if (index > 0) {
      final parentIndex = (index - 1) ~/ 2;
      if (_compare(index, parentIndex) < 0) {
        _swap(index, parentIndex);
        _siftUp(parentIndex);
      }
    }
  }

  void _siftDown(int index) {
    final leftChildIndex = index * 2 + 1;
    final rightChildIndex = index * 2 + 2;
    int smallestChildIndex = index;

    if (leftChildIndex < _heap.length &&
        _compare(leftChildIndex, smallestChildIndex) < 0) {
      smallestChildIndex = leftChildIndex;
    }
    if (rightChildIndex < _heap.length &&
        _compare(rightChildIndex, smallestChildIndex) < 0) {
      smallestChildIndex = rightChildIndex;
    }

    if (smallestChildIndex != index) {
      _swap(index, smallestChildIndex);
      _siftDown(smallestChildIndex);
    }
  }

  void _swap(int a, int b) {
    final temp = _heap[a];
    _heap[a] = _heap[b];
    _heap[b] = temp;
  }

  int _compare(int a, int b) {
    return _comparator(_heap[a].value, _heap[b].value);
  }

  bool get isEmpty => _heap.isEmpty;
}

class _PriorityQueueEntry<E> {
  final int priority;
  final E value;

  _PriorityQueueEntry(this.priority, this.value);
}
