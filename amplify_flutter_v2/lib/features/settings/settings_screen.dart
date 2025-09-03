import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class GraphViewDemoPage extends StatefulWidget {
  const GraphViewDemoPage({super.key});

  @override
  State<GraphViewDemoPage> createState() => _GraphViewDemoPageState();
}

class _GraphViewDemoPageState extends State<GraphViewDemoPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Tree Graph
  final Graph treeGraph = Graph()..isTree = true;
  final BuchheimWalkerConfiguration treeBuilder = BuchheimWalkerConfiguration();

  // Directed Graph
  final Graph directedGraph = Graph();
  // final FruchtermanReingoldConfiguration directedBuilder = FruchtermanReingoldConfiguration();

  // Layered Graph
  final Graph layeredGraph = Graph();
  final SugiyamaConfiguration layeredBuilder = SugiyamaConfiguration();

  final Random random = Random();
  int nodeIdCounter = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializeGraphs();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initializeGraphs() {
    _initializeTreeGraph();
    _initializeDirectedGraph();
    _initializeLayeredGraph();
  }

  void _initializeTreeGraph() {
    // Create organizational chart structure
    final ceo = Node.Id(1);
    final cto = Node.Id(2);
    final cfo = Node.Id(3);
    final hr = Node.Id(4);
    final dev1 = Node.Id(5);
    final dev2 = Node.Id(6);
    final qa = Node.Id(7);
    final designer = Node.Id(8);
    final accountant = Node.Id(9);
    final recruiter = Node.Id(10);

    treeGraph.addEdge(ceo, cto);
    treeGraph.addEdge(ceo, cfo);
    treeGraph.addEdge(ceo, hr);
    treeGraph.addEdge(cto, dev1);
    treeGraph.addEdge(cto, dev2);
    treeGraph.addEdge(cto, qa);
    treeGraph.addEdge(cto, designer);
    treeGraph.addEdge(cfo, accountant);
    treeGraph.addEdge(hr, recruiter);

    treeBuilder
      ..siblingSeparation = 150
      ..levelSeparation = 100
      ..subtreeSeparation = 150
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
  }

  void _initializeDirectedGraph() {
    // Create a social network-like structure
    for (int i = 1; i <= 8; i++) {
      directedGraph.addNode(Node.Id(i));
    }

    directedGraph.addEdge(Node.Id(1), Node.Id(2));
    directedGraph.addEdge(Node.Id(2), Node.Id(3));
    directedGraph.addEdge(Node.Id(1), Node.Id(4));
    directedGraph.addEdge(Node.Id(4), Node.Id(5));
    directedGraph.addEdge(Node.Id(3), Node.Id(6));
    directedGraph.addEdge(Node.Id(5), Node.Id(6));
    directedGraph.addEdge(Node.Id(6), Node.Id(7));
    directedGraph.addEdge(Node.Id(7), Node.Id(8));
    directedGraph.addEdge(Node.Id(8), Node.Id(1));
    directedGraph.addEdge(Node.Id(3), Node.Id(8));
  }

  void _initializeLayeredGraph() {
    // Create a process flow structure
    final start = Node.Id(1);
    final process1 = Node.Id(2);
    final process2 = Node.Id(3);
    final decision = Node.Id(4);
    final process3 = Node.Id(5);
    final process4 = Node.Id(6);
    final end = Node.Id(7);

    layeredGraph.addEdge(start, process1);
    layeredGraph.addEdge(process1, process2);
    layeredGraph.addEdge(process2, decision);
    layeredGraph.addEdge(decision, process3);
    layeredGraph.addEdge(decision, process4);
    layeredGraph.addEdge(process3, end);
    layeredGraph.addEdge(process4, end);

    layeredBuilder
      ..nodeSeparation = 150
      ..levelSeparation = 100
      ..orientation = SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM;
  }

  Widget _buildTreeNodeWidget(Node node) {
    final nodeId = node.key!.value as int;
    final roleMap = {
      1: {'title': 'CEO', 'color': Colors.red, 'icon': Icons.business_center},
      2: {'title': 'CTO', 'color': Colors.blue, 'icon': Icons.computer},
      3: {'title': 'CFO', 'color': Colors.green, 'icon': Icons.account_balance},
      4: {'title': 'HR Manager', 'color': Colors.orange, 'icon': Icons.people},
      5: {'title': 'Developer', 'color': Colors.purple, 'icon': Icons.code},
      6: {'title': 'Developer', 'color': Colors.purple, 'icon': Icons.code},
      7: {
        'title': 'QA Engineer',
        'color': Colors.teal,
        'icon': Icons.bug_report,
      },
      8: {
        'title': 'Designer',
        'color': Colors.pink,
        'icon': Icons.design_services,
      },
      9: {
        'title': 'Accountant',
        'color': Colors.brown,
        'icon': Icons.calculate,
      },
      10: {
        'title': 'Recruiter',
        'color': Colors.indigo,
        'icon': Icons.person_search,
      },
    };

    final roleData =
        roleMap[nodeId] ??
        {'title': 'Employee', 'color': Colors.grey, 'icon': Icons.person};

    return InkWell(
      onTap: () => _showNodeInfo(context, roleData['title'] as String, nodeId),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: roleData['color'] as Color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(roleData['icon'] as IconData, color: Colors.white, size: 24),
            SizedBox(height: 4),
            Text(
              roleData['title'] as String,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectedNodeWidget(Node node) {
    final nodeId = node.key!.value as int;
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.brown,
    ];

    return InkWell(
      onTap: () => _showNodeInfo(context, 'User $nodeId', nodeId),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: colors[nodeId % colors.length],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '$nodeId',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLayeredNodeWidget(Node node) {
    final nodeId = node.key!.value as int;
    final processMap = {
      1: {'title': 'Start', 'color': Colors.green, 'shape': 'circle'},
      2: {'title': 'Input Data', 'color': Colors.blue, 'shape': 'rect'},
      3: {'title': 'Process', 'color': Colors.blue, 'shape': 'rect'},
      4: {'title': 'Decision?', 'color': Colors.orange, 'shape': 'diamond'},
      5: {'title': 'Option A', 'color': Colors.blue, 'shape': 'rect'},
      6: {'title': 'Option B', 'color': Colors.blue, 'shape': 'rect'},
      7: {'title': 'End', 'color': Colors.red, 'shape': 'circle'},
    };

    final processData =
        processMap[nodeId] ??
        {'title': 'Step', 'color': Colors.grey, 'shape': 'rect'};
    final isCircle = processData['shape'] == 'circle';
    final isDiamond = processData['shape'] == 'diamond';

    return InkWell(
      onTap: () =>
          _showNodeInfo(context, processData['title'] as String, nodeId),
      child: Container(
        width: isCircle ? 60 : 80,
        height: isCircle ? 60 : (isDiamond ? 60 : 40),
        decoration: BoxDecoration(
          color: processData['color'] as Color,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle
              ? null
              : (isDiamond ? null : BorderRadius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: isDiamond
            ? Transform.rotate(
                angle: 0.785398, // 45 degrees in radians
                child: Container(
                  decoration: BoxDecoration(
                    color: processData['color'] as Color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Transform.rotate(
                      angle: -0.785398, // -45 degrees to keep text upright
                      child: Text(
                        processData['title'] as String,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              )
            : Center(
                child: Text(
                  processData['title'] as String,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isCircle ? 12 : 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }

  void _showNodeInfo(BuildContext context, String title, int nodeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
            'Node ID: $nodeId\n\nClick to interact with this node.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _addRandomNode() {
    setState(() {
      final currentGraph = _getCurrentGraph();
      final newNodeId = ++nodeIdCounter + 20; // Offset to avoid conflicts
      final newNode = Node.Id(newNodeId);

      if (currentGraph.nodes.isNotEmpty) {
        final randomExistingNode =
            currentGraph.nodes[random.nextInt(currentGraph.nodes.length)];
        currentGraph.addEdge(randomExistingNode, newNode);
      } else {
        currentGraph.addNode(newNode);
      }
    });
  }

  Graph _getCurrentGraph() {
    switch (_tabController.index) {
      case 0:
        return treeGraph;
      case 1:
        return directedGraph;
      case 2:
        return layeredGraph;
      default:
        return treeGraph;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GraphView Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Tree', icon: Icon(Icons.account_tree)),
            Tab(text: 'Directed', icon: Icon(Icons.hub)),
            Tab(text: 'Layered', icon: Icon(Icons.layers)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildTreeView(), _buildDirectedView(), _buildLayeredView()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRandomNode,
        tooltip: 'Add Node',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTreeView() {
    return Column(
      children: [
        _buildControlPanel(),
        Expanded(
          child: InteractiveViewer(
            constrained: false,
            boundaryMargin: EdgeInsets.all(100),
            minScale: 0.1,
            maxScale: 2.0,
            child: GraphView(
              graph: treeGraph,
              algorithm: BuchheimWalkerAlgorithm(
                treeBuilder,
                TreeEdgeRenderer(treeBuilder),
              ),
              paint: Paint()
                ..color = Colors.grey[600]!
                ..strokeWidth = 2
                ..style = PaintingStyle.stroke,
              builder: _buildTreeNodeWidget,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDirectedView() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Social Network Graph',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: InteractiveViewer(
            constrained: false,
            boundaryMargin: EdgeInsets.all(100),
            minScale: 0.1,
            maxScale: 2.0,
            child: GraphView(
              graph: directedGraph,
              algorithm: FruchtermanReingoldAlgorithm(iterations: 1000),
              paint: Paint()
                ..color = Colors.blue
                ..strokeWidth = 1
                ..style = PaintingStyle.stroke,
              builder: _buildDirectedNodeWidget,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLayeredView() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Process Flow Diagram',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: InteractiveViewer(
            constrained: false,
            boundaryMargin: EdgeInsets.all(100),
            minScale: 0.1,
            maxScale: 2.0,
            child: GraphView(
              graph: layeredGraph,
              algorithm: SugiyamaAlgorithm(layeredBuilder),
              paint: Paint()
                ..color = Colors.purple
                ..strokeWidth = 2
                ..style = PaintingStyle.stroke,
              builder: _buildLayeredNodeWidget,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlPanel() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10,
        children: [
          SizedBox(
            width: 120,
            child: TextField(
              decoration: InputDecoration(
                labelText: "Sibling Sep",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
              ),
              onChanged: (text) {
                setState(() {
                  treeBuilder.siblingSeparation = int.tryParse(text) ?? 150;
                });
              },
            ),
          ),
          SizedBox(
            width: 120,
            child: TextField(
              decoration: InputDecoration(
                labelText: "Level Sep",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
              ),
              onChanged: (text) {
                setState(() {
                  treeBuilder.levelSeparation = int.tryParse(text) ?? 100;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                treeBuilder.orientation =
                    treeBuilder.orientation ==
                        BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM
                    ? BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT
                    : BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
              });
            },
            child: Text('Rotate'),
          ),
        ],
      ),
    );
  }
}
