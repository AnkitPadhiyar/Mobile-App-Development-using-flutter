import '../models/question.dart';

enum Subject { networking, dbms, os, dsa, oops }

final Map<Subject, List<Question>> questionsBySubject = {
  Subject.networking: [
    Question(
      question:
          'Which protocol is used to find the hardware (MAC) address of a host?',
      options: ['ICMP', 'ARP', 'TCP', 'UDP'],
      answerIndex: 1,
    ),
    Question(
      question: 'Which layer of the OSI model is responsible for routing?',
      options: ['Application', 'Network', 'Data Link', 'Physical'],
      answerIndex: 1,
    ),
    Question(
      question: 'What port does HTTP use by default?',
      options: ['80', '443', '21', '25'],
      answerIndex: 0,
    ),
    Question(
      question:
          'Which protocol provides reliable, ordered, and error-checked delivery of a stream?',
      options: ['UDP', 'TCP', 'IP', 'ICMP'],
      answerIndex: 1,
    ),
    Question(
      question: 'Which device operates at the Data Link layer?',
      options: ['Router', 'Switch', 'Hub', 'Gateway'],
      answerIndex: 1,
    ),
    Question(
      question: 'What does DNS translate?',
      options: ['IP to MAC', 'Hostname to IP', 'Port to service', 'URL to IP'],
      answerIndex: 1,
    ),
    Question(
      question: 'Which of these is a connectionless protocol?',
      options: ['TCP', 'UDP', 'SCTP', 'DCCP'],
      answerIndex: 1,
    ),
    Question(
      question: 'What is the function of a subnet mask?',
      options: [
        'Identify host portion',
        'Encrypt packets',
        'Translate addresses',
        'Assign ports',
      ],
      answerIndex: 0,
    ),
  ],
  Subject.dbms: [
    Question(
      question: 'Which normal form removes transitive dependency?',
      options: ['1NF', '2NF', '3NF', 'BCNF'],
      answerIndex: 2,
    ),
    Question(
      question: 'Which SQL command is used to remove a table?',
      options: ['DELETE', 'DROP', 'TRUNCATE', 'REMOVE'],
      answerIndex: 1,
    ),
    Question(
      question: 'Which index type is best for exact match queries?',
      options: ['B-tree', 'Bitmap', 'Hash', 'Full-text'],
      answerIndex: 2,
    ),
    Question(
      question: 'What is a transaction property ensuring all-or-nothing?',
      options: ['Atomicity', 'Consistency', 'Isolation', 'Durability'],
      answerIndex: 0,
    ),
    Question(
      question: 'Which command adds a new column to a table in SQL?',
      options: [
        'ALTER TABLE ADD',
        'UPDATE TABLE',
        'CREATE COLUMN',
        'ADD COLUMN',
      ],
      answerIndex: 0,
    ),
    Question(
      question: 'What does ACID stand for in DBMS?',
      options: [
        'Atomicity, Consistency, Isolation, Durability',
        'Access, Control, Integrity, Data',
        'Atomic, Consistent, Isolated, Durable',
        'Authorize, Commit, Index, Delete',
      ],
      answerIndex: 0,
    ),
    Question(
      question: 'Which SQL clause groups rows that have the same values?',
      options: ['GROUP BY', 'ORDER BY', 'HAVING', 'WHERE'],
      answerIndex: 0,
    ),
    Question(
      question:
          'Which join returns all records when there is a match in either left or right table?',
      options: ['INNER JOIN', 'LEFT JOIN', 'RIGHT JOIN', 'FULL OUTER JOIN'],
      answerIndex: 3,
    ),
  ],
  Subject.os: [
    Question(
      question:
          'Which scheduling algorithm gives minimum waiting time for short jobs?',
      options: ['FCFS', 'SJF', 'Round Robin', 'Priority'],
      answerIndex: 1,
    ),
    Question(
      question: 'What does a semaphore primarily provide?',
      options: ['Deadlock', 'Mutual Exclusion', 'Scheduling', 'Paging'],
      answerIndex: 1,
    ),
    Question(
      question:
          'Which memory allocation technique divides memory into fixed-size blocks?',
      options: ['Paging', 'Segmentation', 'Swapping', 'Buddy system'],
      answerIndex: 0,
    ),
    Question(
      question: 'Which condition is necessary for deadlock?',
      options: [
        'Mutual exclusion, Hold and wait, No preemption, Circular wait',
        'Mutual exclusion only',
        'Hold and wait only',
        'Starvation only',
      ],
      answerIndex: 0,
    ),
    Question(
      question: 'What is thrashing in operating systems?',
      options: [
        'Excessive paging causing low CPU utilization',
        'High disk I/O improving performance',
        'Process synchronization',
        'Memory compaction',
      ],
      answerIndex: 0,
    ),
    Question(
      question: 'Which system call is used to create a new process in UNIX?',
      options: ['exec', 'fork', 'spawn', 'create'],
      answerIndex: 1,
    ),
    Question(
      question: 'What does virtual memory provide?',
      options: [
        'Larger apparent memory using disk',
        'Faster CPU clock',
        'Hardware redundancy',
        'Networked storage',
      ],
      answerIndex: 0,
    ),
    Question(
      question: 'Which scheduling is preemptive among these?',
      options: ['FCFS', 'SJF (non-preemptive)', 'Round Robin', 'None'],
      answerIndex: 2,
    ),
  ],
  Subject.dsa: [
    Question(
      question:
          'What is the time complexity of binary search on a sorted array?',
      options: ['O(n)', 'O(log n)', 'O(n log n)', 'O(1)'],
      answerIndex: 1,
    ),
    Question(
      question: 'Which data structure uses LIFO?',
      options: ['Queue', 'Stack', 'Heap', 'Graph'],
      answerIndex: 1,
    ),
    Question(
      question:
          'Which algorithm is used to find shortest paths in a graph with non-negative weights?',
      options: ['Bellman-Ford', 'Dijkstra', 'Floyd-Warshall', 'Kruskal'],
      answerIndex: 1,
    ),
    Question(
      question: 'What is the average time complexity of quicksort?',
      options: ['O(n^2)', 'O(n log n)', 'O(n)', 'O(log n)'],
      answerIndex: 1,
    ),
    Question(
      question:
          'Which data structure is ideal for implementing a priority queue?',
      options: ['Array', 'LinkedList', 'Heap', 'Stack'],
      answerIndex: 2,
    ),
    Question(
      question: 'Which traversal visits nodes in left-root-right order?',
      options: ['Preorder', 'Inorder', 'Postorder', 'Level order'],
      answerIndex: 1,
    ),
    Question(
      question:
          'Which algorithm helps in cycle detection in directed graph using colors?',
      options: ['Kahn', 'DFS with white/gray/black', 'BFS', 'Dijkstra'],
      answerIndex: 1,
    ),
    Question(
      question:
          'What is the worst-case time complexity of inserting into a hash table with chaining?',
      options: ['O(1)', 'O(log n)', 'O(n)', 'O(n log n)'],
      answerIndex: 2,
    ),
  ],
  Subject.oops: [
    Question(
      question:
          'Which OOP concept allows using a derived type where base is expected?',
      options: ['Encapsulation', 'Polymorphism', 'Abstraction', 'Inheritance'],
      answerIndex: 1,
    ),
    Question(
      question:
          'Which keyword is used to inherit a class in many languages like Java/C#?',
      options: ['implement', 'extends', 'inherits', 'uses'],
      answerIndex: 1,
    ),
    Question(
      question:
          'Which principle hides internal details and shows only functionality?',
      options: ['Polymorphism', 'Encapsulation', 'Inheritance', 'Composition'],
      answerIndex: 1,
    ),
    Question(
      question:
          'Which OOP concept allows methods to have the same name but different signatures?',
      options: ['Overloading', 'Overriding', 'Abstraction', 'Encapsulation'],
      answerIndex: 0,
    ),
    Question(
      question:
          'Which relationship is implemented using a pointer/reference from one class to another?',
      options: [
        'Inheritance',
        'Aggregation/Composition',
        'Polymorphism',
        'Encapsulation',
      ],
      answerIndex: 1,
    ),
    Question(
      question: 'Which is an example of runtime polymorphism?',
      options: [
        'Method overloading',
        'Method overriding',
        'Operator overloading',
        'Template',
      ],
      answerIndex: 1,
    ),
    Question(
      question:
          'What is the main advantage of using interfaces (or abstract classes)?',
      options: [
        'Code reuse',
        'Define contracts for behavior',
        'Faster performance',
        'Memory savings',
      ],
      answerIndex: 1,
    ),
    Question(
      question:
          'Which keyword is used in many languages to call a base class constructor?',
      options: ['super', 'base', 'parent', 'this'],
      answerIndex: 0,
    ),
  ],
};
