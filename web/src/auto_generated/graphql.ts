import gql from 'graphql-tag';
import * as Urql from '@urql/vue';
export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
export type Omit<T, K extends keyof T> = Pick<T, Exclude<keyof T, K>>;
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string;
  String: string;
  Boolean: boolean;
  Int: number;
  Float: number;
  DateTime: string;
};

export type ApiKey = {
  __typename?: 'ApiKey';
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  shortToken: Scalars['String'];
  updatedAt: Scalars['DateTime'];
};

export type Division = {
  __typename?: 'Division';
  changedAt?: Maybe<Scalars['DateTime']>;
  divisionHash: Scalars['String'];
  edgeTypes: Array<EdgeType>;
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  nodeTypes: Array<NodeType>;
  project: Project;
  subGraphFilters: Array<SubGraphFilter>;
  summary: Array<Item>;
  tower: Tower;
  updatedAt: Scalars['DateTime'];
};


export type DivisionSummaryArgs = {
  selections: Array<Scalars['String']>;
};

export type DivisionList = {
  __typename?: 'DivisionList';
  entries: Array<Division>;
  limit: Scalars['Int'];
  offset: Scalars['Int'];
  total: Scalars['Int'];
};

export type Edge = {
  __typename?: 'Edge';
  edgeType: EdgeType;
  edgeTypeId: Scalars['ID'];
  endNode: Node;
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  props: Array<Item>;
  startNode: Node;
  updatedAt: Scalars['DateTime'];
};

export type EdgeField = {
  __typename?: 'EdgeField';
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  type: Scalars['String'];
  uid: Scalars['String'];
  updatedAt: Scalars['DateTime'];
};

export type EdgeList = {
  __typename?: 'EdgeList';
  entries: Array<Edge>;
  limit: Scalars['Int'];
  offset: Scalars['Int'];
  total: Scalars['Int'];
};

export type EdgeType = {
  __typename?: 'EdgeType';
  edgeFields: Array<EdgeField>;
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  rules: Array<Rule>;
  uid: Scalars['String'];
  updatedAt: Scalars['DateTime'];
};

export type InputApiKey = {
  name: Scalars['String'];
};

export type InputDivision = {
  name: Scalars['String'];
};

export type InputEdge = {
  edgeTypeId: Scalars['String'];
  endNodeUid?: InputMaybe<Scalars['String']>;
  name: Scalars['String'];
  props?: InputMaybe<Array<InputMaybe<InputItem>>>;
  startNodeUid?: InputMaybe<Scalars['String']>;
};

export type InputEdgeField = {
  name?: InputMaybe<Scalars['String']>;
  type: Scalars['String'];
  uid: Scalars['String'];
};

export type InputEdgeType = {
  name?: InputMaybe<Scalars['String']>;
  uid?: InputMaybe<Scalars['String']>;
};

export type InputItem = {
  key: Scalars['String'];
  val: Scalars['String'];
};

export type InputNode = {
  name: Scalars['String'];
  nodeTypeId: Scalars['String'];
  props?: InputMaybe<Array<InputMaybe<InputItem>>>;
  uid: Scalars['String'];
};

export type InputNodeField = {
  name?: InputMaybe<Scalars['String']>;
  type: Scalars['String'];
  uid: Scalars['String'];
};

export type InputNodeType = {
  name?: InputMaybe<Scalars['String']>;
  uid?: InputMaybe<Scalars['String']>;
};

export type InputProject = {
  name: Scalars['String'];
};

export type InputRule = {
  direction?: InputMaybe<Scalars['String']>;
  endNodeTypeId: Scalars['ID'];
  name: Scalars['String'];
  startNodeTypeId: Scalars['ID'];
};

export type InputSubGraphFilter = {
  name: Scalars['String'];
  uid: Scalars['String'];
};

export type InputTower = {
  inheritable?: InputMaybe<Scalars['Boolean']>;
  name: Scalars['String'];
  public?: InputMaybe<Scalars['Boolean']>;
};

export type Item = {
  __typename?: 'Item';
  key: Scalars['String'];
  val: Scalars['String'];
};

export type Node = {
  __typename?: 'Node';
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  nodeType: NodeType;
  nodeTypeId: Scalars['ID'];
  props: Array<Item>;
  uid: Scalars['String'];
  updatedAt: Scalars['DateTime'];
};

export type NodeField = {
  __typename?: 'NodeField';
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  type: Scalars['String'];
  uid: Scalars['String'];
  updatedAt: Scalars['DateTime'];
};

export type NodeList = {
  __typename?: 'NodeList';
  entries: Array<Node>;
  limit: Scalars['Int'];
  offset: Scalars['Int'];
  total: Scalars['Int'];
};

export type NodeType = {
  __typename?: 'NodeType';
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  nodeFields: Array<NodeField>;
  uid: Scalars['String'];
  updatedAt: Scalars['DateTime'];
};

export type Project = {
  __typename?: 'Project';
  apiKeys: Array<ApiKey>;
  default: Scalars['Boolean'];
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  projectKey: Scalars['String'];
  towers: Array<Tower>;
  updatedAt: Scalars['DateTime'];
};

export type RootMutationType = {
  __typename?: 'RootMutationType';
  createApiKey?: Maybe<ApiKey>;
  createDivision?: Maybe<Division>;
  createEdge?: Maybe<Edge>;
  createEdgeField?: Maybe<EdgeField>;
  createEdgeType?: Maybe<EdgeType>;
  createNode?: Maybe<Node>;
  createNodeField?: Maybe<NodeField>;
  createNodeType?: Maybe<NodeType>;
  createProject?: Maybe<Project>;
  createRule?: Maybe<Rule>;
  createSubGraphFilter?: Maybe<SubGraphFilter>;
  createTower?: Maybe<Tower>;
  signinUser?: Maybe<User>;
  startSubGraph: SubGraphStatus;
  stopSubGraph: SubGraphStatus;
  updateEdge?: Maybe<Edge>;
  updateEdgeType?: Maybe<EdgeType>;
  updateNode?: Maybe<Node>;
  updateNodeType?: Maybe<NodeType>;
  updateSubGraphFilter?: Maybe<SubGraphFilter>;
};


export type RootMutationTypeCreateApiKeyArgs = {
  apiKey: InputApiKey;
};


export type RootMutationTypeCreateDivisionArgs = {
  division: InputDivision;
  towerId: Scalars['ID'];
};


export type RootMutationTypeCreateEdgeArgs = {
  edge: InputEdge;
};


export type RootMutationTypeCreateEdgeFieldArgs = {
  edgeField: InputEdgeField;
  edgeTypeId: Scalars['ID'];
};


export type RootMutationTypeCreateEdgeTypeArgs = {
  divisionId: Scalars['ID'];
  edgeType: InputEdgeType;
};


export type RootMutationTypeCreateNodeArgs = {
  node: InputNode;
};


export type RootMutationTypeCreateNodeFieldArgs = {
  nodeField: InputNodeField;
  nodeTypeId: Scalars['ID'];
};


export type RootMutationTypeCreateNodeTypeArgs = {
  divisionId: Scalars['ID'];
  nodeType: InputNodeType;
};


export type RootMutationTypeCreateProjectArgs = {
  project: InputProject;
};


export type RootMutationTypeCreateRuleArgs = {
  edgeTypeId: Scalars['ID'];
  rule: InputRule;
};


export type RootMutationTypeCreateSubGraphFilterArgs = {
  divisionId: Scalars['ID'];
  subGraphFilter: InputSubGraphFilter;
};


export type RootMutationTypeCreateTowerArgs = {
  tower: InputTower;
};


export type RootMutationTypeStartSubGraphArgs = {
  subGraphFilterId: Scalars['ID'];
};


export type RootMutationTypeStopSubGraphArgs = {
  subGraphFilterId: Scalars['ID'];
};


export type RootMutationTypeUpdateEdgeArgs = {
  edge: InputEdge;
  edgeId: Scalars['ID'];
};


export type RootMutationTypeUpdateEdgeTypeArgs = {
  edgeType: InputEdgeType;
  edgeTypeId: Scalars['ID'];
};


export type RootMutationTypeUpdateNodeArgs = {
  node: InputNode;
  nodeId: Scalars['ID'];
};


export type RootMutationTypeUpdateNodeTypeArgs = {
  nodeType: InputNodeType;
  nodeTypeId: Scalars['ID'];
};


export type RootMutationTypeUpdateSubGraphFilterArgs = {
  qEdge?: InputMaybe<Scalars['String']>;
  qNode?: InputMaybe<Scalars['String']>;
  subGraphFilter?: InputMaybe<InputSubGraphFilter>;
  subGraphFilterId: Scalars['ID'];
};

export type RootQueryType = {
  __typename?: 'RootQueryType';
  currentProject?: Maybe<Project>;
  currentUser: User;
  division?: Maybe<Division>;
  edges: EdgeList;
  nodeBoundEdges: EdgeList;
  nodes: NodeList;
  ping: Status;
  subGraphFilter?: Maybe<SubGraphFilter>;
  subGraphStatus: SubGraphStatus;
  tower?: Maybe<Tower>;
};


export type RootQueryTypeDivisionArgs = {
  divisionId: Scalars['ID'];
};


export type RootQueryTypeEdgesArgs = {
  divisionId: Scalars['ID'];
  limit?: InputMaybe<Scalars['Int']>;
  offset?: InputMaybe<Scalars['Int']>;
  q?: InputMaybe<Scalars['String']>;
};


export type RootQueryTypeNodeBoundEdgesArgs = {
  divisionId: Scalars['ID'];
  limit?: InputMaybe<Scalars['Int']>;
  offset?: InputMaybe<Scalars['Int']>;
  q?: InputMaybe<Scalars['String']>;
  qNode?: InputMaybe<Scalars['String']>;
};


export type RootQueryTypeNodesArgs = {
  divisionId: Scalars['ID'];
  limit?: InputMaybe<Scalars['Int']>;
  offset?: InputMaybe<Scalars['Int']>;
  q?: InputMaybe<Scalars['String']>;
};


export type RootQueryTypeSubGraphFilterArgs = {
  subGraphFilterId: Scalars['ID'];
};


export type RootQueryTypeSubGraphStatusArgs = {
  subGraphFilterId: Scalars['ID'];
};


export type RootQueryTypeTowerArgs = {
  towerId: Scalars['ID'];
};

export type RootSubscriptionType = {
  __typename?: 'RootSubscriptionType';
  newUser: User;
};

export type Rule = {
  __typename?: 'Rule';
  direction: Scalars['String'];
  endNodeType: NodeType;
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  startNodeType: NodeType;
  updatedAt: Scalars['DateTime'];
};

export type Status = {
  __typename?: 'Status';
  status?: Maybe<Scalars['Boolean']>;
};

export type SubGraphFilter = {
  __typename?: 'SubGraphFilter';
  division: Division;
  edgeFilter?: Maybe<Scalars['String']>;
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  nodeFilter?: Maybe<Scalars['String']>;
  project: Project;
  tower: Tower;
  uid: Scalars['String'];
  updatedAt: Scalars['DateTime'];
};

export type SubGraphStatus = {
  __typename?: 'SubGraphStatus';
  changedAt?: Maybe<Scalars['DateTime']>;
  edges?: Maybe<Scalars['Int']>;
  nodes?: Maybe<Scalars['Int']>;
  status?: Maybe<Scalars['Boolean']>;
};

export type Tower = {
  __typename?: 'Tower';
  divisions: DivisionList;
  id: Scalars['ID'];
  inheritable: Scalars['Boolean'];
  inheritedAt?: Maybe<Scalars['DateTime']>;
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  project: Project;
  public: Scalars['Boolean'];
  summary: Array<Item>;
  tower?: Maybe<Tower>;
  updatedAt: Scalars['DateTime'];
};


export type TowerDivisionsArgs = {
  limit?: InputMaybe<Scalars['Int']>;
  offset?: InputMaybe<Scalars['Int']>;
};

export type User = {
  __typename?: 'User';
  activated: Scalars['Boolean'];
  email: Scalars['String'];
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  profileImage?: Maybe<Scalars['String']>;
  projects: Array<Project>;
  role: Scalars['Int'];
  uid?: Maybe<Scalars['String']>;
  updatedAt: Scalars['DateTime'];
};

export type CreateApiKeyMutationVariables = Exact<{
  apiKey: InputApiKey;
}>;


export type CreateApiKeyMutation = { __typename?: 'RootMutationType', createApiKey?: { __typename?: 'ApiKey', id: string } | null };

export type CreateDivisionMutationVariables = Exact<{
  towerId: Scalars['ID'];
  division: InputDivision;
}>;


export type CreateDivisionMutation = { __typename?: 'RootMutationType', createDivision?: { __typename?: 'Division', id: string } | null };

export type CreateEdgeMutationVariables = Exact<{
  edge: InputEdge;
}>;


export type CreateEdgeMutation = { __typename?: 'RootMutationType', createEdge?: { __typename?: 'Edge', id: string } | null };

export type CreateEdgeFieldMutationVariables = Exact<{
  edgeTypeId: Scalars['ID'];
  edgeField: InputEdgeField;
}>;


export type CreateEdgeFieldMutation = { __typename?: 'RootMutationType', createEdgeField?: { __typename?: 'EdgeField', id: string } | null };

export type CreateEdgeTypeMutationVariables = Exact<{
  divisionId: Scalars['ID'];
  edgeType: InputEdgeType;
}>;


export type CreateEdgeTypeMutation = { __typename?: 'RootMutationType', createEdgeType?: { __typename?: 'EdgeType', id: string } | null };

export type CreateNodeMutationVariables = Exact<{
  node: InputNode;
}>;


export type CreateNodeMutation = { __typename?: 'RootMutationType', createNode?: { __typename?: 'Node', id: string } | null };

export type CreateNodeFieldMutationVariables = Exact<{
  nodeTypeId: Scalars['ID'];
  nodeField: InputNodeField;
}>;


export type CreateNodeFieldMutation = { __typename?: 'RootMutationType', createNodeField?: { __typename?: 'NodeField', id: string } | null };

export type CreateNodeTypeMutationVariables = Exact<{
  divisionId: Scalars['ID'];
  nodeType: InputNodeType;
}>;


export type CreateNodeTypeMutation = { __typename?: 'RootMutationType', createNodeType?: { __typename?: 'NodeType', id: string } | null };

export type CreateProjectMutationVariables = Exact<{
  project: InputProject;
}>;


export type CreateProjectMutation = { __typename?: 'RootMutationType', createProject?: { __typename?: 'Project', id: string } | null };

export type CreateRuleMutationVariables = Exact<{
  edgeTypeId: Scalars['ID'];
  rule: InputRule;
}>;


export type CreateRuleMutation = { __typename?: 'RootMutationType', createRule?: { __typename?: 'Rule', id: string } | null };

export type CreateSubGraphFilterMutationVariables = Exact<{
  divisionId: Scalars['ID'];
  subGraphFilter: InputSubGraphFilter;
}>;


export type CreateSubGraphFilterMutation = { __typename?: 'RootMutationType', createSubGraphFilter?: { __typename?: 'SubGraphFilter', id: string } | null };

export type CreateTowerMutationVariables = Exact<{
  tower: InputTower;
}>;


export type CreateTowerMutation = { __typename?: 'RootMutationType', createTower?: { __typename?: 'Tower', id: string } | null };

export type SigninUserMutationVariables = Exact<{ [key: string]: never; }>;


export type SigninUserMutation = { __typename?: 'RootMutationType', signinUser?: { __typename?: 'User', uid?: string | null } | null };

export type StartSubGraphMutationVariables = Exact<{
  subGraphFilterId: Scalars['ID'];
}>;


export type StartSubGraphMutation = { __typename?: 'RootMutationType', startSubGraph: { __typename?: 'SubGraphStatus', status?: boolean | null } };

export type StopSubGraphMutationVariables = Exact<{
  subGraphFilterId: Scalars['ID'];
}>;


export type StopSubGraphMutation = { __typename?: 'RootMutationType', stopSubGraph: { __typename?: 'SubGraphStatus', status?: boolean | null } };

export type UpdateEdgeMutationVariables = Exact<{
  edgeId: Scalars['ID'];
  edge: InputEdge;
}>;


export type UpdateEdgeMutation = { __typename?: 'RootMutationType', updateEdge?: { __typename?: 'Edge', id: string } | null };

export type UpdateEdgeTypeMutationVariables = Exact<{
  edgeTypeId: Scalars['ID'];
  edgeType: InputEdgeType;
}>;


export type UpdateEdgeTypeMutation = { __typename?: 'RootMutationType', updateEdgeType?: { __typename?: 'EdgeType', id: string } | null };

export type UpdateNodeMutationVariables = Exact<{
  nodeId: Scalars['ID'];
  node: InputNode;
}>;


export type UpdateNodeMutation = { __typename?: 'RootMutationType', updateNode?: { __typename?: 'Node', id: string } | null };

export type UpdateNodeTypeMutationVariables = Exact<{
  nodeTypeId: Scalars['ID'];
  nodeType: InputNodeType;
}>;


export type UpdateNodeTypeMutation = { __typename?: 'RootMutationType', updateNodeType?: { __typename?: 'NodeType', id: string } | null };

export type UpdateSubGraphFilterMutationVariables = Exact<{
  subGraphFilterId: Scalars['ID'];
  subGraphFilter?: InputMaybe<InputSubGraphFilter>;
  qNode?: InputMaybe<Scalars['String']>;
  qEdge?: InputMaybe<Scalars['String']>;
}>;


export type UpdateSubGraphFilterMutation = { __typename?: 'RootMutationType', updateSubGraphFilter?: { __typename?: 'SubGraphFilter', id: string } | null };

export type DivisionEdgeTypesQueryVariables = Exact<{
  divisionId: Scalars['ID'];
}>;


export type DivisionEdgeTypesQuery = { __typename?: 'RootQueryType', division?: { __typename?: 'Division', id: string, name: string, edgeTypes: Array<{ __typename?: 'EdgeType', id: string, name: string, uid: string, edgeFields: Array<{ __typename?: 'EdgeField', id: string, name: string, type: string, uid: string }>, rules: Array<{ __typename?: 'Rule', id: string, name: string, startNodeType: { __typename?: 'NodeType', id: string, name: string }, endNodeType: { __typename?: 'NodeType', id: string, name: string } }> }> } | null };

export type DivisionNodeTypesQueryVariables = Exact<{
  divisionId: Scalars['ID'];
}>;


export type DivisionNodeTypesQuery = { __typename?: 'RootQueryType', division?: { __typename?: 'Division', id: string, name: string, nodeTypes: Array<{ __typename?: 'NodeType', id: string, name: string, uid: string, nodeFields: Array<{ __typename?: 'NodeField', id: string, name: string, type: string, uid: string }> }> } | null };

export type DivisionSubGraphFiltersQueryVariables = Exact<{
  divisionId: Scalars['ID'];
}>;


export type DivisionSubGraphFiltersQuery = { __typename?: 'RootQueryType', division?: { __typename?: 'Division', id: string, name: string, subGraphFilters: Array<{ __typename?: 'SubGraphFilter', id: string, name: string, uid: string }> } | null };

export type DivisionSummaryQueryVariables = Exact<{
  divisionId: Scalars['ID'];
  selections: Array<Scalars['String']> | Scalars['String'];
}>;


export type DivisionSummaryQuery = { __typename?: 'RootQueryType', division?: { __typename?: 'Division', id: string, name: string, project: { __typename?: 'Project', id: string, name: string, default: boolean }, tower: { __typename?: 'Tower', id: string, name: string }, summary: Array<{ __typename?: 'Item', key: string, val: string }> } | null };

export type EdgesQueryVariables = Exact<{
  divisionId: Scalars['ID'];
  q?: InputMaybe<Scalars['String']>;
  offset?: InputMaybe<Scalars['Int']>;
  limit?: InputMaybe<Scalars['Int']>;
}>;


export type EdgesQuery = { __typename?: 'RootQueryType', edges: { __typename?: 'EdgeList', limit: number, offset: number, total: number, entries: Array<{ __typename?: 'Edge', id: string, name: string, edgeTypeId: string, props: Array<{ __typename?: 'Item', key: string, val: string }>, edgeType: { __typename?: 'EdgeType', id: string, name: string, uid: string }, startNode: { __typename?: 'Node', id: string, name: string, uid: string }, endNode: { __typename?: 'Node', id: string, name: string, uid: string } }> } };

export type NodeBoundEdgesQueryVariables = Exact<{
  divisionId: Scalars['ID'];
  q?: InputMaybe<Scalars['String']>;
  qNode?: InputMaybe<Scalars['String']>;
  offset?: InputMaybe<Scalars['Int']>;
  limit?: InputMaybe<Scalars['Int']>;
}>;


export type NodeBoundEdgesQuery = { __typename?: 'RootQueryType', nodeBoundEdges: { __typename?: 'EdgeList', limit: number, offset: number, total: number, entries: Array<{ __typename?: 'Edge', id: string, name: string, edgeTypeId: string, props: Array<{ __typename?: 'Item', key: string, val: string }>, edgeType: { __typename?: 'EdgeType', id: string, name: string, uid: string }, startNode: { __typename?: 'Node', id: string, name: string, uid: string }, endNode: { __typename?: 'Node', id: string, name: string, uid: string } }> } };

export type NodesQueryVariables = Exact<{
  divisionId: Scalars['ID'];
  q?: InputMaybe<Scalars['String']>;
  offset?: InputMaybe<Scalars['Int']>;
  limit?: InputMaybe<Scalars['Int']>;
}>;


export type NodesQuery = { __typename?: 'RootQueryType', nodes: { __typename?: 'NodeList', limit: number, offset: number, total: number, entries: Array<{ __typename?: 'Node', id: string, name: string, uid: string, nodeTypeId: string, props: Array<{ __typename?: 'Item', key: string, val: string }>, nodeType: { __typename?: 'NodeType', id: string, name: string } }> } };

export type PingQueryVariables = Exact<{ [key: string]: never; }>;


export type PingQuery = { __typename?: 'RootQueryType', ping: { __typename?: 'Status', status?: boolean | null } };

export type ProjectApiKeysQueryVariables = Exact<{ [key: string]: never; }>;


export type ProjectApiKeysQuery = { __typename?: 'RootQueryType', currentProject?: { __typename?: 'Project', id: string, name: string, apiKeys: Array<{ __typename?: 'ApiKey', id: string, name: string, shortToken: string }> } | null };

export type ProjectTowersQueryVariables = Exact<{ [key: string]: never; }>;


export type ProjectTowersQuery = { __typename?: 'RootQueryType', currentProject?: { __typename?: 'Project', id: string, name: string, towers: Array<{ __typename?: 'Tower', id: string, name: string }> } | null };

export type SubGraphFilterQueryVariables = Exact<{
  subGraphFilterId: Scalars['ID'];
}>;


export type SubGraphFilterQuery = { __typename?: 'RootQueryType', subGraphFilter?: { __typename?: 'SubGraphFilter', id: string, name: string, uid: string, nodeFilter?: string | null, edgeFilter?: string | null, division: { __typename?: 'Division', id: string, name: string }, tower: { __typename?: 'Tower', id: string, name: string }, project: { __typename?: 'Project', id: string, name: string, default: boolean } } | null };

export type SubGraphStatusQueryVariables = Exact<{
  subGraphFilterId: Scalars['ID'];
}>;


export type SubGraphStatusQuery = { __typename?: 'RootQueryType', subGraphStatus: { __typename?: 'SubGraphStatus', status?: boolean | null, nodes?: number | null, edges?: number | null, changedAt?: string | null } };

export type TowerDivisionsQueryVariables = Exact<{
  towerId: Scalars['ID'];
  offset?: InputMaybe<Scalars['Int']>;
  limit?: InputMaybe<Scalars['Int']>;
}>;


export type TowerDivisionsQuery = { __typename?: 'RootQueryType', tower?: { __typename?: 'Tower', id: string, name: string, divisions: { __typename?: 'DivisionList', offset: number, limit: number, total: number, entries: Array<{ __typename?: 'Division', id: string, name: string, divisionHash: string }> }, project: { __typename?: 'Project', id: string, name: string, default: boolean } } | null };

export type UserProjectsQueryVariables = Exact<{ [key: string]: never; }>;


export type UserProjectsQuery = { __typename?: 'RootQueryType', currentUser: { __typename?: 'User', id: string, projects: Array<{ __typename?: 'Project', id: string, name: string, projectKey: string, default: boolean }> } };

export type NewUserSubscriptionVariables = Exact<{ [key: string]: never; }>;


export type NewUserSubscription = { __typename?: 'RootSubscriptionType', newUser: { __typename?: 'User', id: string, name: string } };


export const CreateApiKeyDocument = gql`
    mutation CreateApiKey($apiKey: InputApiKey!) {
  createApiKey(apiKey: $apiKey) {
    id
  }
}
    `;

export function useCreateApiKeyMutation() {
  return Urql.useMutation<CreateApiKeyMutation, CreateApiKeyMutationVariables>(CreateApiKeyDocument);
};
export const CreateDivisionDocument = gql`
    mutation CreateDivision($towerId: ID!, $division: InputDivision!) {
  createDivision(towerId: $towerId, division: $division) {
    id
  }
}
    `;

export function useCreateDivisionMutation() {
  return Urql.useMutation<CreateDivisionMutation, CreateDivisionMutationVariables>(CreateDivisionDocument);
};
export const CreateEdgeDocument = gql`
    mutation CreateEdge($edge: InputEdge!) {
  createEdge(edge: $edge) {
    id
  }
}
    `;

export function useCreateEdgeMutation() {
  return Urql.useMutation<CreateEdgeMutation, CreateEdgeMutationVariables>(CreateEdgeDocument);
};
export const CreateEdgeFieldDocument = gql`
    mutation CreateEdgeField($edgeTypeId: ID!, $edgeField: InputEdgeField!) {
  createEdgeField(edgeTypeId: $edgeTypeId, edgeField: $edgeField) {
    id
  }
}
    `;

export function useCreateEdgeFieldMutation() {
  return Urql.useMutation<CreateEdgeFieldMutation, CreateEdgeFieldMutationVariables>(CreateEdgeFieldDocument);
};
export const CreateEdgeTypeDocument = gql`
    mutation CreateEdgeType($divisionId: ID!, $edgeType: InputEdgeType!) {
  createEdgeType(divisionId: $divisionId, edgeType: $edgeType) {
    id
  }
}
    `;

export function useCreateEdgeTypeMutation() {
  return Urql.useMutation<CreateEdgeTypeMutation, CreateEdgeTypeMutationVariables>(CreateEdgeTypeDocument);
};
export const CreateNodeDocument = gql`
    mutation CreateNode($node: InputNode!) {
  createNode(node: $node) {
    id
  }
}
    `;

export function useCreateNodeMutation() {
  return Urql.useMutation<CreateNodeMutation, CreateNodeMutationVariables>(CreateNodeDocument);
};
export const CreateNodeFieldDocument = gql`
    mutation CreateNodeField($nodeTypeId: ID!, $nodeField: InputNodeField!) {
  createNodeField(nodeTypeId: $nodeTypeId, nodeField: $nodeField) {
    id
  }
}
    `;

export function useCreateNodeFieldMutation() {
  return Urql.useMutation<CreateNodeFieldMutation, CreateNodeFieldMutationVariables>(CreateNodeFieldDocument);
};
export const CreateNodeTypeDocument = gql`
    mutation CreateNodeType($divisionId: ID!, $nodeType: InputNodeType!) {
  createNodeType(divisionId: $divisionId, nodeType: $nodeType) {
    id
  }
}
    `;

export function useCreateNodeTypeMutation() {
  return Urql.useMutation<CreateNodeTypeMutation, CreateNodeTypeMutationVariables>(CreateNodeTypeDocument);
};
export const CreateProjectDocument = gql`
    mutation CreateProject($project: InputProject!) {
  createProject(project: $project) {
    id
  }
}
    `;

export function useCreateProjectMutation() {
  return Urql.useMutation<CreateProjectMutation, CreateProjectMutationVariables>(CreateProjectDocument);
};
export const CreateRuleDocument = gql`
    mutation CreateRule($edgeTypeId: ID!, $rule: InputRule!) {
  createRule(edgeTypeId: $edgeTypeId, rule: $rule) {
    id
  }
}
    `;

export function useCreateRuleMutation() {
  return Urql.useMutation<CreateRuleMutation, CreateRuleMutationVariables>(CreateRuleDocument);
};
export const CreateSubGraphFilterDocument = gql`
    mutation CreateSubGraphFilter($divisionId: ID!, $subGraphFilter: InputSubGraphFilter!) {
  createSubGraphFilter(divisionId: $divisionId, subGraphFilter: $subGraphFilter) {
    id
  }
}
    `;

export function useCreateSubGraphFilterMutation() {
  return Urql.useMutation<CreateSubGraphFilterMutation, CreateSubGraphFilterMutationVariables>(CreateSubGraphFilterDocument);
};
export const CreateTowerDocument = gql`
    mutation CreateTower($tower: InputTower!) {
  createTower(tower: $tower) {
    id
  }
}
    `;

export function useCreateTowerMutation() {
  return Urql.useMutation<CreateTowerMutation, CreateTowerMutationVariables>(CreateTowerDocument);
};
export const SigninUserDocument = gql`
    mutation SigninUser {
  signinUser {
    uid
  }
}
    `;

export function useSigninUserMutation() {
  return Urql.useMutation<SigninUserMutation, SigninUserMutationVariables>(SigninUserDocument);
};
export const StartSubGraphDocument = gql`
    mutation StartSubGraph($subGraphFilterId: ID!) {
  startSubGraph(subGraphFilterId: $subGraphFilterId) {
    status
  }
}
    `;

export function useStartSubGraphMutation() {
  return Urql.useMutation<StartSubGraphMutation, StartSubGraphMutationVariables>(StartSubGraphDocument);
};
export const StopSubGraphDocument = gql`
    mutation StopSubGraph($subGraphFilterId: ID!) {
  stopSubGraph(subGraphFilterId: $subGraphFilterId) {
    status
  }
}
    `;

export function useStopSubGraphMutation() {
  return Urql.useMutation<StopSubGraphMutation, StopSubGraphMutationVariables>(StopSubGraphDocument);
};
export const UpdateEdgeDocument = gql`
    mutation UpdateEdge($edgeId: ID!, $edge: InputEdge!) {
  updateEdge(edgeId: $edgeId, edge: $edge) {
    id
  }
}
    `;

export function useUpdateEdgeMutation() {
  return Urql.useMutation<UpdateEdgeMutation, UpdateEdgeMutationVariables>(UpdateEdgeDocument);
};
export const UpdateEdgeTypeDocument = gql`
    mutation UpdateEdgeType($edgeTypeId: ID!, $edgeType: InputEdgeType!) {
  updateEdgeType(edgeTypeId: $edgeTypeId, edgeType: $edgeType) {
    id
  }
}
    `;

export function useUpdateEdgeTypeMutation() {
  return Urql.useMutation<UpdateEdgeTypeMutation, UpdateEdgeTypeMutationVariables>(UpdateEdgeTypeDocument);
};
export const UpdateNodeDocument = gql`
    mutation UpdateNode($nodeId: ID!, $node: InputNode!) {
  updateNode(nodeId: $nodeId, node: $node) {
    id
  }
}
    `;

export function useUpdateNodeMutation() {
  return Urql.useMutation<UpdateNodeMutation, UpdateNodeMutationVariables>(UpdateNodeDocument);
};
export const UpdateNodeTypeDocument = gql`
    mutation UpdateNodeType($nodeTypeId: ID!, $nodeType: InputNodeType!) {
  updateNodeType(nodeTypeId: $nodeTypeId, nodeType: $nodeType) {
    id
  }
}
    `;

export function useUpdateNodeTypeMutation() {
  return Urql.useMutation<UpdateNodeTypeMutation, UpdateNodeTypeMutationVariables>(UpdateNodeTypeDocument);
};
export const UpdateSubGraphFilterDocument = gql`
    mutation UpdateSubGraphFilter($subGraphFilterId: ID!, $subGraphFilter: InputSubGraphFilter, $qNode: String, $qEdge: String) {
  updateSubGraphFilter(
    subGraphFilterId: $subGraphFilterId
    subGraphFilter: $subGraphFilter
    qNode: $qNode
    qEdge: $qEdge
  ) {
    id
  }
}
    `;

export function useUpdateSubGraphFilterMutation() {
  return Urql.useMutation<UpdateSubGraphFilterMutation, UpdateSubGraphFilterMutationVariables>(UpdateSubGraphFilterDocument);
};
export const DivisionEdgeTypesDocument = gql`
    query DivisionEdgeTypes($divisionId: ID!) {
  division(divisionId: $divisionId) {
    id
    name
    edgeTypes {
      id
      name
      uid
      edgeFields {
        id
        name
        type
        uid
      }
      rules {
        id
        name
        startNodeType {
          id
          name
        }
        endNodeType {
          id
          name
        }
      }
    }
  }
}
    `;

export function useDivisionEdgeTypesQuery(options: Omit<Urql.UseQueryArgs<never, DivisionEdgeTypesQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<DivisionEdgeTypesQuery>({ query: DivisionEdgeTypesDocument, ...options });
};
export const DivisionNodeTypesDocument = gql`
    query DivisionNodeTypes($divisionId: ID!) {
  division(divisionId: $divisionId) {
    id
    name
    nodeTypes {
      id
      name
      uid
      nodeFields {
        id
        name
        type
        uid
      }
    }
  }
}
    `;

export function useDivisionNodeTypesQuery(options: Omit<Urql.UseQueryArgs<never, DivisionNodeTypesQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<DivisionNodeTypesQuery>({ query: DivisionNodeTypesDocument, ...options });
};
export const DivisionSubGraphFiltersDocument = gql`
    query DivisionSubGraphFilters($divisionId: ID!) {
  division(divisionId: $divisionId) {
    id
    name
    subGraphFilters {
      id
      name
      uid
    }
  }
}
    `;

export function useDivisionSubGraphFiltersQuery(options: Omit<Urql.UseQueryArgs<never, DivisionSubGraphFiltersQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<DivisionSubGraphFiltersQuery>({ query: DivisionSubGraphFiltersDocument, ...options });
};
export const DivisionSummaryDocument = gql`
    query DivisionSummary($divisionId: ID!, $selections: [String!]!) {
  division(divisionId: $divisionId) {
    id
    name
    project {
      id
      name
      default
    }
    tower {
      id
      name
    }
    summary(selections: $selections) {
      key
      val
    }
  }
}
    `;

export function useDivisionSummaryQuery(options: Omit<Urql.UseQueryArgs<never, DivisionSummaryQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<DivisionSummaryQuery>({ query: DivisionSummaryDocument, ...options });
};
export const EdgesDocument = gql`
    query Edges($divisionId: ID!, $q: String, $offset: Int, $limit: Int) {
  edges(divisionId: $divisionId, q: $q, offset: $offset, limit: $limit) {
    entries {
      id
      name
      edgeTypeId
      props {
        key
        val
      }
      edgeType {
        id
        name
        uid
      }
      startNode {
        id
        name
        uid
      }
      endNode {
        id
        name
        uid
      }
    }
    limit
    offset
    total
  }
}
    `;

export function useEdgesQuery(options: Omit<Urql.UseQueryArgs<never, EdgesQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<EdgesQuery>({ query: EdgesDocument, ...options });
};
export const NodeBoundEdgesDocument = gql`
    query NodeBoundEdges($divisionId: ID!, $q: String, $qNode: String, $offset: Int, $limit: Int) {
  nodeBoundEdges(
    divisionId: $divisionId
    q: $q
    qNode: $qNode
    offset: $offset
    limit: $limit
  ) {
    entries {
      id
      name
      edgeTypeId
      props {
        key
        val
      }
      edgeType {
        id
        name
        uid
      }
      startNode {
        id
        name
        uid
      }
      endNode {
        id
        name
        uid
      }
    }
    limit
    offset
    total
  }
}
    `;

export function useNodeBoundEdgesQuery(options: Omit<Urql.UseQueryArgs<never, NodeBoundEdgesQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<NodeBoundEdgesQuery>({ query: NodeBoundEdgesDocument, ...options });
};
export const NodesDocument = gql`
    query Nodes($divisionId: ID!, $q: String, $offset: Int, $limit: Int) {
  nodes(divisionId: $divisionId, q: $q, offset: $offset, limit: $limit) {
    entries {
      id
      name
      uid
      nodeTypeId
      props {
        key
        val
      }
      nodeType {
        id
        name
      }
    }
    limit
    offset
    total
  }
}
    `;

export function useNodesQuery(options: Omit<Urql.UseQueryArgs<never, NodesQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<NodesQuery>({ query: NodesDocument, ...options });
};
export const PingDocument = gql`
    query Ping {
  ping {
    status
  }
}
    `;

export function usePingQuery(options: Omit<Urql.UseQueryArgs<never, PingQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<PingQuery>({ query: PingDocument, ...options });
};
export const ProjectApiKeysDocument = gql`
    query ProjectApiKeys {
  currentProject {
    id
    name
    apiKeys {
      id
      name
      shortToken
    }
  }
}
    `;

export function useProjectApiKeysQuery(options: Omit<Urql.UseQueryArgs<never, ProjectApiKeysQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<ProjectApiKeysQuery>({ query: ProjectApiKeysDocument, ...options });
};
export const ProjectTowersDocument = gql`
    query ProjectTowers {
  currentProject {
    id
    name
    towers {
      id
      name
    }
  }
}
    `;

export function useProjectTowersQuery(options: Omit<Urql.UseQueryArgs<never, ProjectTowersQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<ProjectTowersQuery>({ query: ProjectTowersDocument, ...options });
};
export const SubGraphFilterDocument = gql`
    query SubGraphFilter($subGraphFilterId: ID!) {
  subGraphFilter(subGraphFilterId: $subGraphFilterId) {
    id
    name
    uid
    nodeFilter
    edgeFilter
    division {
      id
      name
    }
    tower {
      id
      name
    }
    project {
      id
      name
      default
    }
  }
}
    `;

export function useSubGraphFilterQuery(options: Omit<Urql.UseQueryArgs<never, SubGraphFilterQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<SubGraphFilterQuery>({ query: SubGraphFilterDocument, ...options });
};
export const SubGraphStatusDocument = gql`
    query SubGraphStatus($subGraphFilterId: ID!) {
  subGraphStatus(subGraphFilterId: $subGraphFilterId) {
    status
    nodes
    edges
    changedAt
  }
}
    `;

export function useSubGraphStatusQuery(options: Omit<Urql.UseQueryArgs<never, SubGraphStatusQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<SubGraphStatusQuery>({ query: SubGraphStatusDocument, ...options });
};
export const TowerDivisionsDocument = gql`
    query TowerDivisions($towerId: ID!, $offset: Int, $limit: Int) {
  tower(towerId: $towerId) {
    id
    name
    divisions(offset: $offset, limit: $limit) {
      entries {
        id
        name
        divisionHash
      }
      offset
      limit
      total
    }
    project {
      id
      name
      default
    }
  }
}
    `;

export function useTowerDivisionsQuery(options: Omit<Urql.UseQueryArgs<never, TowerDivisionsQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<TowerDivisionsQuery>({ query: TowerDivisionsDocument, ...options });
};
export const UserProjectsDocument = gql`
    query UserProjects {
  currentUser {
    id
    projects {
      id
      name
      projectKey
      default
    }
  }
}
    `;

export function useUserProjectsQuery(options: Omit<Urql.UseQueryArgs<never, UserProjectsQueryVariables>, 'query'> = {}) {
  return Urql.useQuery<UserProjectsQuery>({ query: UserProjectsDocument, ...options });
};
export const NewUserDocument = gql`
    subscription NewUser {
  newUser {
    id
    name
  }
}
    `;

export function useNewUserSubscription<R = NewUserSubscription>(options: Omit<Urql.UseSubscriptionArgs<never, NewUserSubscriptionVariables>, 'query'> = {}, handler?: Urql.SubscriptionHandlerArg<NewUserSubscription, R>) {
  return Urql.useSubscription<NewUserSubscription, R, NewUserSubscriptionVariables>({ query: NewUserDocument, ...options }, handler);
};