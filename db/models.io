# -*- mode: io; coding: utf-8 -*-
######################################################################
# File: db/models.io                               Part of kstracker #
#                                                                    #
# Copyright (C) 2014 Joachim Pileborg and individual contributors.   #
# All rights reserved.                                               #
#                                                                    #
# Redistribution and use in source and binary forms, with or without #
# modification, are permitted provided that the following conditions #
# are met:                                                           #
#                                                                    #
#   o Redistributions of source code must retain the above copyright #
#     notice, this list of conditions and the following disclaimer.  #
#   o Redistributions in binary form must reproduce the above        #
#     copyright notice, this list of conditions and the following    #
#     disclaimer in the documentation and/or other materials         #
#     provided with the distribution.                                #
#   o Neither the name of kstracker nor the names of its             #
#     contributors may be used to endorse or promote products        #
#     derived from this software without specific prior written      #
#     permission.                                                    #
#                                                                    #
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND             #
# CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,        #
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF           #
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE           #
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS  #
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,#
# OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,           #
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR #
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY       #
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR     #
# TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF #
# THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF    #
# SUCH DAMAGE.                                                       #
#                                                                    #
######################################################################

models := Object clone do(
    with := method(db,
        self User := Iorm Model with(db session) setup(
            setTableName("users")

            newField("name", Iorm VarcharField clone setLength(20) setNotNull)
            newField("pwd", Iorm VarcharField clone setLength(40) setNotNull)  # SHA1
            newField("first_name", Iorm VarcharField clone setLength(20))
            newField("last_name", Iorm VarcharField clone setLength(20))
            newField("email", Iorm VarcharField clone setLength(40) setNotNull)
            newField("info", Iorm TextField clone)        # General free-form info
            newField("ksname", Iorm TextField clone)      # Kickstarter user name
        )

        self Project := Iorm Model with(db session) setup(
            setTableName("projects")

            newField("name", Iorm VarcharField clone setLength(20) setNotNull)
            newField("ksid", Iorm VarcharField clone setLength(20) setNotNull)
            newField("pledge", Iorm IntegerField clone) # Total pledged for project
            newField("reward", Iorm IntegerField clone) # Reward level for pledge

            # The user pledging for this project
            newField("user", Iorm ForeignKeyField with(self User))
        )

        self Perk := Iorm Model with(db session) setup(
            setTableName("perks")

            newField("project", Iorm ForeignKeyField with(self Project))
            newField("perk", Iorm TextField clone)
            newfield("delivered", Iorm BooleanField clone)  # Perk has been delivered?
        )

        self Addon := Iorm Model with(db session) setup(
            setTableName("addons")

            newField("project", Iorm ForeignKeyField with(self Project))
            newField("addon", Iorm TextField clone)
            newField("cost", Iorm IntegerField clone)
            newfield("delivered", Iorm BooleanField clone)  # Addon has been delivered?
        )
    )
)
