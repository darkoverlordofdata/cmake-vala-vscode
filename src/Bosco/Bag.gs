[indent=4]
namespace Bosco.ECS
    class Bag of T : DarkMatter

        _queue : array of IComponent
        _used : int


        construct(alloc : int = POOL_SIZE)
            _used = 0
            _queue = new array of IComponent[alloc]


        prop length : int
            get
                return _used

        def clear()
            _used = 0

        def push(component : IComponent)
            if _used >= _queue.length
                _queue += (IComponent)component
            else
                _queue[_used++] = (IComponent)component

        def pop() : T
            return (T)_queue[--_used]
