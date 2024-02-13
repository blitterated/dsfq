FROM pyenv-dde

MAINTAINER blitterated blitterated@protonmail.com

RUN apt update
RUN apt --yes upgrade

RUN apt --yes install flac

ENV SFQ_DIR=/opt/sfq
ENV SFQ_EXEC="$SFQ_DIR/sfq"
RUN mkdir -p "$SFQ_DIR"

COPY test/py-env-args "$SFQ_DIR"/py-env-args
COPY test/sh-env-args "$SFQ_DIR"/sh-env-args

WORKDIR "$SFQ_DIR"

# Download and set up the sfq script

RUN <<EOT bash -xev
    curl "https://raw.githubusercontent.com/pahandav/sfq/master/sfq.py" -o sfq
    chmod +x sfq

    # disable last line in script requiring user input to continue
    sed -i "\\\$s/^/\#/" sfq
EOT

# Create a wrapper script to set up the environment

WORKDIR /

#ARG ARG_SCRIPT="$SFQ_DIR/sh-env-args"
ARG ARG_SCRIPT="$SFQ_DIR/py-env-args"
#ARG ARG_SCRIPT="$SFQ_EXEC"

# BEGIN Double Heredoc
#RUN <<EOT cat > $SFQ_DIR/sfq-wrapper
#RUN <<EOT cat > sfq-wrapper
RUN <<EOT bash -xev
cat <<EOF > sfq-wrapper
#!/bin/bash -l

# The hashbang above needs the -l switch to force a login shell.
# This gets bash to source .bash_profile which in turn sources .bashrc.
# .bashrc calls the .dde.rc scripts which sets up the environment and pyenv.

# Escape backslash and dollar for sh used by Docker.
# Remaining backslash escapes dollar for bash.
exec "$ARG_SCRIPT" "\\\$@"
EOF

chmod +x sfq-wrapper
EOT
# END Double Heredoc

# DELETEME: These can be removed after testing
#RUN chmod +x $SFQ_DIR/$ARG_SCRIPT
RUN chmod +x $ARG_SCRIPT

WORKDIR /soundfonts

#ENV PATH="\$PATH:$SFQ_DIR"

ENTRYPOINT ["/sfq-wrapper"]
