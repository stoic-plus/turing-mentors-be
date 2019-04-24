# Turing Mentors (API)

### About

[Turing School of Software and Design](https://turing.io/) is a 7 month intensive _experience_ that prepares people for a career in software development.

__The Turing Mission__

Turing's mission is to unlock human potential by training a diverse and inclusive student body to succeed in high-fulfillment technical careers. We are a community committed to challenging ourselves and each other to build the knowledge, skills, and understanding needed for long-term success.

__Turing mentors__

This is the backend to an application that is designed to ease the process of current students finding alumni or other developers to mentor them. Collaboration and community are such a big part of the software development industry - this app seeks to help facilitate that.

[Deployed Front End application](https://turing-mentors.herokuapp.com/)

[Front End Repository](https://github.com/geet084/turing-mentors)

### Table of Contents

- [About](#about)
- [Getting Started](#getting-started)
- [Endpoints](#endpoints)
  * [GET mentors](#get-mentors)
  * [GET mentor and mentee](#get-mentor-and-mentee)
  * [Background On Endpoints](#background-on-endpoints)
  * [POST mentors / mentee](#mentor-and-mentee-creation)
  * [PUT mentors / mentee](#mentor-and-mentee-update)
  * [DELETE mentors / mentee](#mentor-and-mentee-destroy)
- [Built With](#built-with)
- [Developers](#developers)
- [Contributing](#contributing)

__Overview__

Provides three endpoints for user functionality of the app
* user creation (mentor and mentee)
* retrieving users (mentors)


## Getting Started

### Prerequisites

You'll need the following:

__Software__
* Ruby (2.4.5)
* [Bundler](https://bundler.io/)

### Installing

Run the following:
```
$ git clone https://github.com/stoic-plus/turing-mentors-be.git
$ bundle install
```

### Running Test Suite

(After cloning down repo)

```
cd turing-mentors-be
rspec
```

## Endpoints

All responses are serialized using __fast_json_api__ gem

#### Base Url

`https://turing-mentors-be.herokuapp.com`


### GET mentors

`GET /api/v1/mentors`

Takes two parameters __`location`__ and __`tech_skills`__

_location must be specified, tech_skills is optional_


__location__

Three options: `all`, `remote`, `denver` (remote is not denver)

__tech_skills__

String of comma separated values - all lowercase

<details><summary>Example Request:</summary>

```
GET /api/v1/mentors?location=all&tech_skills=ruby,python
```

</details>

<details><summary>Example Response:</summary>

```
"data": [
  {
            "id": "5",
            "type": "mentor",
            "attributes": {
                "first_name": "Grace",
                "last_name": "Hopper",
                "cohort": 8210,
                "program": "BE",
                "current_job": "computer scientist",
                "background": "One of the first programmers of the Harvard Mark I computer, she was a pioneer of computer programming who invented one of the first linkers",
                "mentor": true,
                "location": "New York, NY",
                "tech_skills": [
                    "ruby",
                    "javascript",
                    "python",
                    "java",
                    "elixir",
                    "c",
                    "php",
                    "swift",
                    "sql"
                ],
                "non_tech_skills": [
                    "stress management",
                    "public speaking",
                    "resumes",
                    "technical interviews",
                    "parenting",
                    "wellness"
                ],
                "availability": {
                    "0": [
                        false,
                        true,
                        false
                    ],
                    "1": [
                        false,
                        false,
                        false
                    ],
                    "2": [
                        false,
                        false,
                        false
                    ],
                    "3": [
                        false,
                        true,
                        false
                    ],
                    "4": [
                        false,
                        false,
                        false
                    ],
                    "5": [
                        false,
                        false,
                        false
                    ],
                    "6": [
                        false,
                        false,
                        false
                    ]
                },
                "identities": [
                    "scientist"
                ],
                "contact_details": {
                  "slack": "@hopper",
                  "email": "g_hopper@gmail.com",
                  "phone": "555-555-5555"
                }
            }
    }
]
```

</details>

<br>

### Get Mentor and Mentee

`POST /api/v1/mentors` `POST /api/v1/mentees`

All parameters are required:


<details><summary>Example Request for /mentors/:id :</summary>

```
GET /api/v1/mentors/5
Content-Type: application/json
Accept: application/json
```

</details>


<details><summary>Example Response:</summary>

```
"data": {
            "id": "5",
            "type": "mentor",
            "attributes": {
                "first_name": "Grace",
                "last_name": "Hoper",
                "cohort": 8210,
                "program": "BE",
                "current_job": "computer scientist",
                "background": "One of the first programmers of the Harvard Mark I computer, she was a pioneer of computer programming who invented one of the first linkers",
                "mentor": true,
                "location": "New York, NY",
                "tech_skills": [
                    "ruby",
                    "javascript",
                    "python",
                    "java",
                    "elixir",
                    "c",
                    "php",
                    "swift",
                    "sql"
                ],
                "non_tech_skills": [
                    "stress management",
                    "public speaking",
                    "resumes",
                    "technical interviews",
                    "parenting",
                    "wellness"
                ],
                "availability": {
                    "0": [
                        false,
                        true,
                        false
                    ],
                    "1": [
                        false,
                        false,
                        false
                    ],
                    "2": [
                        false,
                        false,
                        false
                    ],
                    "3": [
                        false,
                        true,
                        false
                    ],
                    "4": [
                        false,
                        false,
                        false
                    ],
                    "5": [
                        false,
                        false,
                        false
                    ],
                    "6": [
                        false,
                        false,
                        false
                    ]
                },
                "identities": [
                    "scientist"
                ],
                "contact_details": {
                  "slack": "@hopper",
                  "email": "g_hopper@gmail.com",
                  "phone": "555-555-5555"
                }
            }
        }
```

</details>

<br>


<details><summary>Example Request for /mentees/:id :</summary>

```
GET /api/v1/mentees/5
Content-Type: application/json
Accept: application/json
```

</details>

<details><summary>Example Response:</summary>

```
"data": {
            "id": "5",
            "type": "mentee",
            "attributes": {
                "first_name": "jordan",
                "last_name": "leranger",
                "cohort": 8210,
                "program": "BE",
                "current_job": "student",
                "background": "A person",
                "mentor": false,
                "location": "Denver, CO",
                "availability": {
                    "0": [
                        false,
                        true,
                        false
                    ],
                    "1": [
                        false,
                        false,
                        false
                    ],
                    "2": [
                        false,
                        false,
                        false
                    ],
                    "3": [
                        false,
                        true,
                        false
                    ],
                    "4": [
                        false,
                        false,
                        false
                    ],
                    "5": [
                        false,
                        false,
                        false
                    ],
                    "6": [
                        false,
                        false,
                        false
                    ]
                },
                "identities": [
                    "ski bum"
                ],
                "contact_details": {
                  "slack": "@slack",
                  "email": "leranger@gmail.com",
                  "phone": "555-555-5555"
                }
            }
        }
```

</details>


### Background on Endpoints

`identities, tech_skills, non_tech_skills`

* all take an array of ids that correspond to rows in those tables
  * To __create__ a mentor that is fluent in Ruby and Python - you would provide:
    `tech_skills: [1, 3]` in the body
  * To __update__ a mentee by adding identities - you would provide:
    `identities: [4, 5]` in the body

`tech_skills, non_tech_skills, location, current_job`
* Are not specified for the `/mentee` route (for both `POST` and `PUT`)

__Availability__

Is a hash with:
  * Day of week keys (an integer from 0-6)
  * Array, of booleans, value (Boolean for Morning, Afternoon, Evening)
    * `"0": [false, false, true]` would indicate evening availability on Monday

### Mentor and Mentee Creation

`POST /api/v1/mentors` `POST /api/v1/mentees`

All parameters are required:


<details><summary>Example Request for /mentors:</summary>

```
POST /api/v1/mentors
Content-Type: application/json
Accept: application/json

{
    "first_name": "Grace",
    "last_name": "Hoper",
    "identities": [0],
    "cohort": 8210,
    "program": "BE",
    "current_job": "computer scientist",
    "location": "New York, NY",
    "slack": "@hopper",
    "email": "g_hopper@gmail.com",
    "phone": "555-555-5555",
    "background": "Grace Brewster Murray Hopper was an American computer scientist and United States Navy rear admiral. One of the first programmers of the Harvard Mark I computer, she was a pioneer of computer programming who invented one of the first linkers",
    "availability": {
        "0": [
            false,
            true,
            false
        ],
        "1": [
            false,
            false,
            false
        ],
        "2": [
            false,
            true,
            false
        ],
        "3": [
            false,
            false,
            false
        ],
        "4": [
            false,
            false,
            false
        ],
        "5": [
            false,
            false,
            false
        ],
        "6": [
            false,
            false,
            false
        ]
    },
    "tech_skills": [
        "4", "1", "3"
    ],
    "non_tech_skills": [
        "6", "5", "4"
    ]
}
```

</details>


<details><summary>Example Response:</summary>

```
{
            "id": "5",
            "type": "mentor",
            "attributes": {
                "first_name": "Grace",
                "last_name": "Hoper",
                "cohort": 8210,
                "program": "BE",
                "current_job": "computer scientist",
                "background": "One of the first programmers of the Harvard Mark I computer, she was a pioneer of computer programming who invented one of the first linkers",
                "mentor": true,
                "location": "New York, NY",
                "tech_skills": [
                    "ruby",
                    "javascript",
                    "python",
                    "java",
                    "elixir",
                    "c",
                    "php",
                    "swift",
                    "sql"
                ],
                "non_tech_skills": [
                    "stress management",
                    "public speaking",
                    "resumes",
                    "technical interviews",
                    "parenting",
                    "wellness"
                ],
                "availability": {
                    "0": [
                        false,
                        true,
                        false
                    ],
                    "1": [
                        false,
                        false,
                        false
                    ],
                    "2": [
                        false,
                        false,
                        false
                    ],
                    "3": [
                        false,
                        true,
                        false
                    ],
                    "4": [
                        false,
                        false,
                        false
                    ],
                    "5": [
                        false,
                        false,
                        false
                    ],
                    "6": [
                        false,
                        false,
                        false
                    ]
                },
                "identities": [
                    "scientist"
                ],
                "contact_details": {
                  "slack": "@hopper",
                  "email": "g_hopper@gmail.com",
                  "phone": "555-555-5555"
                }
            }
        }
```

</details>

<br>


<details><summary>Example Request for /mentee:</summary>

```
POST /api/v1/mentees
Content-Type: application/json
Accept: application/json

{
  "background": "A person",
  "cohort": 1810,
  "program": "BE",
  "email": "leranger@gmail.com",
  "first_name": "jordan",
  "identities": [8],
  "last_name": "leranger",
  "phone": "555-555-5555",
  "slack": "@slack",
  "availability": {
    0 => [true, false, true],
    1 => true,
    2 => [true, false, false],
    3 => [true, false, true],
    4 => [false, false, true],
    5 => [true, false, true],
    6 => [true, false, false]
  }
}
```

</details>

<details><summary>Example Response:</summary>

```
"data": {
            "id": "5",
            "type": "mentee",
            "attributes": {
                "first_name": "jordan",
                "last_name": "leranger",
                "cohort": 8210,
                "program": "BE",
                "current_job": "student",
                "background": "A person",
                "mentor": false,
                "location": "Denver, CO",
                "availability": {
                    "0": [
                        false,
                        true,
                        false
                    ],
                    "1": [
                        false,
                        false,
                        false
                    ],
                    "2": [
                        false,
                        false,
                        false
                    ],
                    "3": [
                        false,
                        true,
                        false
                    ],
                    "4": [
                        false,
                        false,
                        false
                    ],
                    "5": [
                        false,
                        false,
                        false
                    ],
                    "6": [
                        false,
                        false,
                        false
                    ]
                },
                "identities": [
                    "ski bum"
                ],
                "contact_details": {
                  "slack": "@slack",
                  "email": "leranger@gmail.com",
                  "phone": "555-555-5555"
                }
            }
        }
```

</details>

### Mentor and Mentee Update

`PUT /api/v1/mentors` `PUT /api/v1/mentees`

Not all parameters are required. Very similar to post


Currently the following attributes can only be _added_ to on this endpoint, NOT deleted. That will be a separate endpoint for security purposes.

`identities, tech_skills, non_tech_skills`
 * Latter two only apply to mentors


<br>


<details><summary>Example Request for /mentors:</summary>

```
PUT /api/v1/mentors
Content-Type: application/json
Accept: application/json

{
    "first_name": "Grace",
    "last_name": "Hoper",
    "identities": [0],
    "cohort": 8210,
    "program": "BE",
    "current_job": "computer scientist",
    "location": "New York, NY",
    "slack": "@hopper",
    "email": "g_hopper@gmail.com",
    "phone": "555-555-5555",
    "background": "Grace Brewster Murray Hopper was an American computer scientist and United States Navy rear admiral. One of the first programmers of the Harvard Mark I computer, she was a pioneer of computer programming who invented one of the first linkers",
    "availability": {
        "0": [
            false,
            true,
            false
        ],
        "1": [
            false,
            false,
            false
        ],
        "2": [
            false,
            true,
            false
        ],
        "3": [
            false,
            false,
            false
        ],
        "4": [
            false,
            false,
            false
        ],
        "5": [
            false,
            false,
            false
        ],
        "6": [
            false,
            false,
            false
        ]
    },
    "tech_skills": [
        "4", "1", "3"
    ],
    "non_tech_skills": [
        "6", "5", "4"
    ]
}
```

</details>


<details><summary>Example Response:</summary>

```
{
            "id": "5",
            "type": "mentor",
            "attributes": {
                "first_name": "Grace",
                "last_name": "Hoper",
                "cohort": 8210,
                "program": "BE",
                "current_job": "computer scientist",
                "background": "One of the first programmers of the Harvard Mark I computer, she was a pioneer of computer programming who invented one of the first linkers",
                "mentor": true,
                "location": "New York, NY",
                "tech_skills": [
                    "ruby",
                    "javascript",
                    "python",
                    "java",
                    "elixir",
                    "c",
                    "php",
                    "swift",
                    "sql"
                ],
                "non_tech_skills": [
                    "stress management",
                    "public speaking",
                    "resumes",
                    "technical interviews",
                    "parenting",
                    "wellness"
                ],
                "availability": {
                    "0": [
                        false,
                        true,
                        false
                    ],
                    "1": [
                        false,
                        false,
                        false
                    ],
                    "2": [
                        false,
                        false,
                        false
                    ],
                    "3": [
                        false,
                        true,
                        false
                    ],
                    "4": [
                        false,
                        false,
                        false
                    ],
                    "5": [
                        false,
                        false,
                        false
                    ],
                    "6": [
                        false,
                        false,
                        false
                    ]
                },
                "identities": [
                    "scientist"
                ],
                "contact_details": {
                  "slack": "@hopper",
                  "email": "g_hopper@gmail.com",
                  "phone": "555-555-5555"
                }
            }
        }
```

</details>

<br>


<details><summary>Example Request for /mentee:</summary>

```
POST /api/v1/mentees
Content-Type: application/json
Accept: application/json

{
  "background": "A person",
  "cohort": 1810,
  "program": "BE",
  "email": "leranger@gmail.com",
  "first_name": "jordan",
  "identities": [8],
  "last_name": "leranger",
  "phone": "555-555-5555",
  "slack": "@slack",
  "availability": {
    0 => [true, false, true],
    1 => true,
    2 => [true, false, false],
    3 => [true, false, true],
    4 => [false, false, true],
    5 => [true, false, true],
    6 => [true, false, false]
  }
}
```

</details>

<details><summary>Example Response:</summary>

```
"data": {
            "id": "5",
            "type": "mentee",
            "attributes": {
                "first_name": "jordan",
                "last_name": "leranger",
                "cohort": 8210,
                "program": "BE",
                "current_job": "student",
                "background": "A person",
                "mentor": false,
                "location": "Denver, CO",
                "availability": {
                    "0": [
                        false,
                        true,
                        false
                    ],
                    "1": [
                        false,
                        false,
                        false
                    ],
                    "2": [
                        false,
                        false,
                        false
                    ],
                    "3": [
                        false,
                        true,
                        false
                    ],
                    "4": [
                        false,
                        false,
                        false
                    ],
                    "5": [
                        false,
                        false,
                        false
                    ],
                    "6": [
                        false,
                        false,
                        false
                    ]
                },
                "identities": [
                    "ski bum"
                ],
                "contact_details": {
                  "slack": "@slack",
                  "email": "leranger@gmail.com",
                  "phone": "555-555-5555"
                }
            }
        }
```

</details>

## Mentor and Mentee Destroy


`DELETE /api/v1/mentors/:id` `DELETE /api/v1/mentees/:id`

Removing a user currently removes entries in the following tables (dependent destroy)
* `contact_details`
* `availabilities`
* `user_identities`
* `user_tech_skills`
* `user_non_tech_skills`

_When those entries are present - mentees have less information_

<br>


<details><summary>Example Request for /mentors:</summary>

```
DELETE /api/v1/mentors/2
Content-Type: application/json
Accept: application/json
```

</details>

<br />

__Response__
* Simply a 204 status code


## Built With

* Ruby on Rails
* Continuous Integration with [CircleCi](https://circleci.com/)
* [Rspec](http://rspec.info/) - Testing Framework
* [fast_jsonapi](https://github.com/Netflix/fast_jsonapi) - JSON serializer for Ruby Objects

## Developers

* **Ricardo Ledesma** - [Personal Website](https://www.ricardoledesma.tech/)
* __Travis Gee__ - [Github](https://github.com/geet084)

## Contributing

We are looking to continually develop this app for Turing School of Software and Design - if you are interested in helping: make a PR to
  * https://github.com/stoic-plus/turing-mentors-be (BE)
  * https://github.com/geet084/turing-mentors (FE)
