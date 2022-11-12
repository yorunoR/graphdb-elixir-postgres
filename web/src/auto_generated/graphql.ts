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

export type Division = {
  __typename?: 'Division';
  changedAt?: Maybe<Scalars['DateTime']>;
  divisionHash: Scalars['String'];
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  project: Project;
  updatedAt: Scalars['DateTime'];
};

export type DivisionList = {
  __typename?: 'DivisionList';
  entries: Array<Division>;
  limit: Scalars['Int'];
  offset: Scalars['Int'];
  total: Scalars['Int'];
};

export type InputDivision = {
  name: Scalars['String'];
};

export type InputProject = {
  name: Scalars['String'];
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

export type Project = {
  __typename?: 'Project';
  default: Scalars['Boolean'];
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  towers: Array<Tower>;
  updatedAt: Scalars['DateTime'];
};

export type RootMutationType = {
  __typename?: 'RootMutationType';
  createDivision?: Maybe<Division>;
  createProject?: Maybe<Project>;
  createTower?: Maybe<Tower>;
  signinUser?: Maybe<User>;
};


export type RootMutationTypeCreateDivisionArgs = {
  division: InputDivision;
  towerId: Scalars['ID'];
};


export type RootMutationTypeCreateProjectArgs = {
  project: InputProject;
};


export type RootMutationTypeCreateTowerArgs = {
  tower: InputTower;
};

export type RootQueryType = {
  __typename?: 'RootQueryType';
  currentProject?: Maybe<Project>;
  currentUser: User;
  ping: Status;
  tower?: Maybe<Tower>;
};


export type RootQueryTypeTowerArgs = {
  towerId: Scalars['ID'];
};

export type RootSubscriptionType = {
  __typename?: 'RootSubscriptionType';
  newUser: User;
};

export type Status = {
  __typename?: 'Status';
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

export type CreateDivisionMutationVariables = Exact<{
  towerId: Scalars['ID'];
  division: InputDivision;
}>;


export type CreateDivisionMutation = { __typename?: 'RootMutationType', createDivision?: { __typename?: 'Division', id: string } | null };

export type CreateProjectMutationVariables = Exact<{
  project: InputProject;
}>;


export type CreateProjectMutation = { __typename?: 'RootMutationType', createProject?: { __typename?: 'Project', id: string } | null };

export type CreateTowerMutationVariables = Exact<{
  tower: InputTower;
}>;


export type CreateTowerMutation = { __typename?: 'RootMutationType', createTower?: { __typename?: 'Tower', id: string } | null };

export type SigninUserMutationVariables = Exact<{ [key: string]: never; }>;


export type SigninUserMutation = { __typename?: 'RootMutationType', signinUser?: { __typename?: 'User', uid?: string | null } | null };

export type PingQueryVariables = Exact<{ [key: string]: never; }>;


export type PingQuery = { __typename?: 'RootQueryType', ping: { __typename?: 'Status', status?: boolean | null } };

export type ProjectTowersQueryVariables = Exact<{ [key: string]: never; }>;


export type ProjectTowersQuery = { __typename?: 'RootQueryType', currentProject?: { __typename?: 'Project', id: string, name: string, towers: Array<{ __typename?: 'Tower', id: string, name: string }> } | null };

export type TowerDivisionsQueryVariables = Exact<{
  towerId: Scalars['ID'];
  offset?: InputMaybe<Scalars['Int']>;
  limit?: InputMaybe<Scalars['Int']>;
}>;


export type TowerDivisionsQuery = { __typename?: 'RootQueryType', tower?: { __typename?: 'Tower', id: string, name: string, divisions: { __typename?: 'DivisionList', offset: number, limit: number, total: number, entries: Array<{ __typename?: 'Division', id: string, name: string, divisionHash: string }> }, project: { __typename?: 'Project', id: string, name: string, default: boolean } } | null };

export type UserProjectsQueryVariables = Exact<{ [key: string]: never; }>;


export type UserProjectsQuery = { __typename?: 'RootQueryType', currentUser: { __typename?: 'User', id: string, projects: Array<{ __typename?: 'Project', id: string, name: string, default: boolean }> } };

export type NewUserSubscriptionVariables = Exact<{ [key: string]: never; }>;


export type NewUserSubscription = { __typename?: 'RootSubscriptionType', newUser: { __typename?: 'User', id: string, name: string } };


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